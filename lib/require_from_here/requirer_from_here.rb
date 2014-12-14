module RequireFromHere

  class RequirerFromHere
    include Utils

    def initialize block
      path = extract_require_path_from block
      @require = make_require_method_body_for path
    end

    def require *names
      @require.call *names
    end

  end

end
