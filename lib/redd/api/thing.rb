require "redd/api/base"

module Redd
  module API
    # A reddit thing.
    # @see http://www.reddit.com/dev/api#fullnames
    class Thing < Base
      # @return [String] an object kind, usually t1-5.
      property :kind

      # @return [String] the unique id for the object.
      property :id

      # @return [String] The fullname of the thing.
      def fullname
        @response[:name] || "#{kind}_#{id}"
      end

      # Check for equality.
      # @param other The other object.
      # @return [Boolean]
      def ==(other)
        other.is_a?(Thing) && fullname == other.fullname
      end
    end
  end
end
