require "multi_json"

module Redd
  module Response
    # JSON API parser.
    class ParseJSON
      def initialize(app = nil)
        @app = app
      end

      def call(request_env)
        @app.call(request_env).on_complete { |env| on_complete(env) }
      end

      def on_complete(env)
        env[:body] = MultiJson.load(env[:body], symbolize_keys: true)
      rescue MultiJson::ParseError
        raise JSONError.new(env), env[:body]
      end
    end
  end
end
