module Simpler
  class Router
    class Route
      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action

        @params = {}
        @path_regexp = path_regexp(path)
      end

      def match?(method, path)
        path_match = path.match(@path_regexp)

        if @method == method && path_match
          @params = path_match.named_captures
        end
      end

      def path_regexp(path)
        Regexp.new "#{path.gsub(/(:\w+)/, '(?<\1>\w+)').delete(':')}$"
      end
    end
  end
end
