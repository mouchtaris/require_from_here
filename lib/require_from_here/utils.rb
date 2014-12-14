module RequireFromHere::Utils

  private

  def extract_require_path_from block
    src, _ = block.source_location
    File.dirname src
  end

  def make_require_method_body_for path
    lambda { |*names|
      Kernel.require File.join path, *names
    }
  end

end
