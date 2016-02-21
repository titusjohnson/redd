require "multi_json"
require "redd/error"

module Redd
  # Faraday response middleware.
  module Response
    # JSON API parser.
    class ParseJSON
      def initialize(app = nil)
        @app = app
      end

      def call(request_env)
        @app.call(request_env).on_complete { |env| on_complete(env) }
      end

      private

      def on_complete(env)
        env[:body] = MultiJson.load(env[:body], symbolize_keys: true)
      rescue MultiJson::ParseError
        raise Error::JSONError.new(env), env[:body]
      end
    end
  end
end
