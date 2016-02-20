module Redd
  module Client
    class Base
      # Utility functions for the all clients.
      module APIUtils
        # The kind strings and the objects that should be used for them.
        OBJECT_KINDS = {}.freeze

        # Request and create an object from the response.
        # @param [Symbol] meth The method to use.
        # @param [String] path The path to visit.
        # @param [Hash] params The data to send with the request.
        # @return [API::Base] The object returned from the request.
        def req_object(meth, path, params = {})
          body = req(meth, path, params).body
          obj = OBJECT_KINDS.fetch(body[:kind], API::Base)
          obj.from_response(self, flat)
        end
      end
    end
  end
end
