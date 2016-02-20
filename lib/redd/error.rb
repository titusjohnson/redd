module Redd
  # A module that contains all the possible errors that can be raised.
  # @note If you are getting a non-500 error, please raise a GitHub issue!
  module Error
    # @abstract The base error type for all client errors.
    class APIError < StandardError
      # @return [Integer] the response code (probably not a 200!).
      attr_reader :status

      # @return [Hash{String => String}] the response headers.
      attr_reader :headers

      # @return [Hash, String] the parsed response, if possible.
      attr_reader :body

      # Create a APIError
      # @param [Hash] env the Faraday environment.
      def initialize(env)
        @status  = env[:status]
        @headers = env[:response_headers]
        @body    = env[:body]
      end
    end

    # A JSON response was expected, but a non JSON response was found.
    class JSONError < APIError; end
  end
end
