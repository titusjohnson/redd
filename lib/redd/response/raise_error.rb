require "redd/error"

module Redd
  module Response
    # JSON API parser.
    class RaiseError
      def initialize(app = nil)
        @app = app
      end

      def call(request_env)
        @app.call(request_env).on_complete { |env| on_complete(env) }
      end

      def on_complete(env)
        error = detect_error(env)
        raise error.new(env), env[:body].to_s if error
      end

      private

      # A very error detect "algorithm" :P
      # @todo Improve!
      def detect_error(env)
        Redd::Error::APIError if env[:status] != 200
      end
    end
  end
end
