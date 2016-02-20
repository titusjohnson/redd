require "redd/client/base"

module Redd
  # The possible API client types.
  module Client
    # A client with all the scopes, perfect for bots.
    # @note Remember to add the bot to the app's developers.
    class Script < Base
      # @return [String] the client id.
      attr_reader :client_id

      # @return [String] the username you're logged in with.
      attr_reader :username

      # Create a userless client.
      # @param [String] client_id the client id.
      # @param [String] secret the client secret.
      # @param [String] username the username of the bot.
      # @param [String] password the password.
      # @see Base#initialize
      def initialize(client_id, secret, username, password, **options)
        super(**options)
        @client_id = client_id
        @secret    = secret
        @username  = username
        @password  = password
      end

      # @see Base#authorize!
      def authorize!
        response = auth_connection.post do |req|
          req.url "/api/v1/access_token"
          req.headers["User-Agent"]    = @user_agent
          req.headers["Authorization"] = Faraday.basic_auth(@client_id, @secret)
          req.params["grant_type"]     = "password"
          req.params["username"]       = @username
          req.params["password"]       = @password
        end
        @access = API::Access.new(self, response.body)
      end

      alias refresh! authorize!

      # Dispose of the access token when you're done with it.
      def revoke!
        auth_connection.post do |req|
          req.url "/api/v1/revoke_token"
          req.headers["User-Agent"]    = @user_agent
          req.headers["Authorization"] = Faraday.basic_auth(@client_id, @secret)
          req.params["token"]          = @access.access_token
          req.params["token_type_hint"] = "access_token"
        end
        @access = nil
      end
    end
  end
end
