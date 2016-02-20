require "redd/api/base"

module Redd
  module API
    # Authentication details for OAuth2 access.
    # @todo Add methods to refresh or revoke.
    class Access < Base
      # @return [String] the access token used to access the users account.
      property :access_token

      # @return [String, nil] the refresh token, if the access was permanent.
      property :refresh_token

      # @return [Array] the scopes that the client is allowed to access.
      attr_reader :scope

      # @return [Time] the time when the token was issued.
      attr_reader :issued_at

      # Create a new Access object.
      # @see Base
      def initialize(client, response)
        super

        @scope = response.key?(:scope) ? response[:scope].split(",") : []
        @issued_at = response[:issued_at] || Time.now
      end

      # @return [Boolean] whether the access is temporary.
      def temporary?
        !refresh_token
      end

      # @return [Boolean] whether the access is permanent.
      def permanent?
        !temporary?
      end

      # @return [Time] the time when the access token expires.
      # @note It is pessimistic by 60 seconds just in case.
      def expires_at
        @issued_at + @expires_in - 60
      end

      # @return [Boolean] Whether the access has expired.
      def expired?
        Time.now > expires_at
      end
    end
  end
end
