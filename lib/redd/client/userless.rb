require "redd/client/base"

module Redd
  # The possible API client types.
  module Client
    # A strong independent client that don't need no user.
    # They also don't get refresh tokens :/
    class Userless < Base
      # @return [String] the client id.
      attr_reader :client_id

      # Create a userless client.
      # @param [String] client_id the client id.
      # @param [String] secret the client secret.
      # @see Base#initialize
      def initialize(client_id, secret, **options)
        super(**options)
        @client_id = client_id
        @secret = secret
      end

      # @see Base#authorize!
      # @see https://github.com/reddit/reddit/wiki/OAuth2#application-only-oauth
      def authorize!
        response = auth_connection.post do |req|
          req.url "/api/v1/access_token"
          req.headers["User-Agent"]    = @user_agent
          req.headers["Authorization"] = Faraday.basic_auth(@client_id, @secret)
          req.params["grant_type"]     = "client_credentials"
        end
        @access = API::Access.new(self, response.body)
      end
    end
  end
end
