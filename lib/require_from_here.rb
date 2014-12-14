require "require_from_here/version"

module RequireFromHere

  class << self

    private

    def extract_require_path_from block
      src, _ = block.source_location
      File.dirname src
    end

    def extract_target_from block
      block.binding.eval 'self'
    end

    def make_method_body_for path
      lambda { |*names|
        require (File.join path, *names)
      }
    end

    def install modewl, path
      @installed ||= {}
      !@installed.has_key?(modewl) && @installed[modewl] = path
    end

  end

  def self.install_on &block
    raise ArgumentError, "An empty block (such as '{}') should be provided" unless block

    target = extract_target_from block
    raise ArgumentError, 'should be called for Modules only' unless target.is_a? Module

    path      = extract_require_path_from block
    installed = install target, path
    raise ArgumentError, "already installed on #{target} with base-path #{path}" unless installed

    body = make_method_body_for path
    target.define_singleton_method :require_from_here, body
  end

  def self.require_from_here &block
    names = block.call
    names = [names] unless names.is_a? Array
    if names.empty? || names.any? { |t| t.instance_eval { not is_a? String } }
      then raise ArgumentError, "path elements must be strings" 
    end

    path = extract_require_path_from block
    make_method_body_for(path).call *names
  end

end
