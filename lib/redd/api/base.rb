module Redd
  # API response containers.
  module API
    # Base class for response objects to inherit from.
    class Base
      # @return [Hash{Symbol => Object}] the original response.
      attr_reader :response

      # Create a new object from a response hash and a client.
      # @param [Client::Base] client the client to use for requests.
      # @param [Hash{Symbol => Object}] response the response hash.
      def initialize(client, response)
        @response = response
        @client = client
      end

      # @return [Hash{Symbol => Object}] the hash representation of the object.
      def to_h
        @response
      end

      class << self
        # Create from a nested response object.
        # @param [Client::Base] client the client to use for requests.
        # @param [Hash{Symbol => Object}] response the response body.
        def from_response(client, response)
          data = response[:data]
          data[:kind] = response[:kind]
          new(client, data)
        end

        private

        # Define an attribute method.
        # @param [Symbol] name the property to create.
        # @!macro [attach] property
        #   @!attribute [r] $1
        def property(name)
          define_method(name) { @response[name] }
          define_method(:"#{name}?") { @response[name] ? true : false }
        end
      end
    end
  end
end
