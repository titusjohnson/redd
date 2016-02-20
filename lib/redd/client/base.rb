require "faraday"

require "redd/version"
require "redd/rate_limit"
require "redd/api/access"
require "redd/response/parse_json"
require "redd/response/raise_error"

require "redd/client/base/api_utils"

module Redd
  # The possible API client types.
  module Client
    # @abstract A simple client for the others to inherit from.
    class Base
      include APIUtils

      # @return [String] the user-agent of the client.
      # @note Reddit recommends "redd:<app ID>:<version string> (by /u/???)"
      attr_reader :user_agent

      # @return [String] the oauth authentication endpoint.
      attr_reader :auth_endpoint

      # @return [String] the reddit api url.
      attr_reader :api_endpoint

      # @return [#after_limit] the class responsible for rate limiter.
      attr_accessor :rate_limit

      # @return [API::Access] the object with session-specific details.
      attr_accessor :access

      # Create a new client with the given options.
      # @param [String] user_agent the user agent to use for each request.
      # @param [String] auth_endpoint the authentication endpoint to use.
      # @param [String] api_endpoint the api endpoint to use.
      # @param [RateLimit] rate_limit the rate limiter to use.
      def initialize(
          user_agent:    "redd:default:v#{Redd::VERSION} (by unknown)",
          auth_endpoint: "https://www.reddit.com",
          api_endpoint:  "https://oauth.reddit.com",
          rate_limit:    RateLimit.new(1)
      )
        @user_agent    = user_agent.freeze
        @auth_endpoint = auth_endpoint.freeze
        @api_endpoint  = api_endpoint.freeze
        @rate_limit    = rate_limit
        @access        = API::Access.new(self, expires_in: 0)
      end

      # @abstract Authorize the client with the given credentials.
      def authorize!(*)
        raise NotImplementedError, "This client cannot be authorized."
      end

      # @abstract Refresh the access token. Only works if permanent was
      #   requested.
      def refresh!(*)
        raise NotImplementedError,
              "This client cannot refresh tokens. Try reauthorizing."
      end

      # @abstract Revoke the access token or optionally, the refresh token.
      def revoke!(*)
        raise NotImplementedError,
              "This client does not support revoking tokens."
      end

      # Sends the request to the given path with the given params. This is the
      # most frequent use case.
      # @param [:get, :post, :put, :patch, :delete] meth the method to use.
      # @param [String] path The path under the api_endpoint to request.
      # @param [Hash] params The parameters to send with the request.
      # @return [Hash] The response body.
      def req(meth, path, params = {})
        @rate_limit.after_limit do
          connection.send meth do |req|
            req.url(path)
            req.headers.merge!(base_headers)
            req.params.merge!(base_params)
            req.params.merge!(params)
          end
        end
      end

      private

      # @return [Faraday::Connection] A new or existing API connection.
      def connection
        @connection ||= Faraday.new(@api_endpoint, builder: middleware)
      end

      # @return [Faraday::Connection] A new or existing auth connection.
      def auth_connection
        @auth_connection ||= Faraday.new(@auth_endpoint, builder: middleware)
      end

      # @return [Faraday::RackBuilder] The middleware to use when creating the
      #   connection.
      def middleware
        @middleware ||= Faraday::RackBuilder.new do |builder|
          builder.use Response::RaiseError
          builder.use Response::ParseJSON
          builder.use Faraday::Request::Multipart
          builder.use Faraday::Request::UrlEncoded
          builder.adapter Faraday.default_adapter
        end
      end

      # @return [Hash] The minimum parameters to send with every request.
      def base_params
        @default_params ||= { api_type: "json" }.freeze
      end

      # @return [Hash] A hash of the base headers used for requests.
      def base_headers
        {
          "User-Agent"    => @user_agent,
          "Authorization" => "bearer #{@access.access_token}"
        }
      end
    end
  end
end
