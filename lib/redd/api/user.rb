require "redd/api/thing"

module Redd
  module API
    # The model for a reddit user.
    class User < Thing
      # @!group All users

      # @!attribute [r] name
      #   @return [String] the username.
      property :name

      # @!attribute [r] is_friend
      #   @return [Boolean] whether the user is your friend.
      property :is_friend

      # @!attribute [r] created
      #   @return [Integer] the epoch time of creation.
      #   @note Prefer created_utc, apparently it's more accurate.
      #   @todo convert to Time.
      property :created

      # @!attribute [r] hide_from_robots
      #   @return [Boolean] whether the user prefers to hide from search.
      property :hide_from_robots

      # @!attribute [r] created_utc
      #   @return [Integer] the epoch time of creation, in UTC time.
      #   @todo convert to Time.
      property :created_utc

      # @!attribute [r] link_karma
      #   @return [Integer] the amount of link karma.
      property :link_karma

      # @!attribute [r] comment_karma
      #   @return [Integer] the amount of comment karma.
      property :comment_karma

      # @!attribute [r] is_gold
      #   @return [Boolean] whether the user has gold.
      property :is_gold

      # @!attribute [r] is_mod
      #   @return [Boolean] whether the user is a moderator of a subreddit.
      property :is_mod

      # @!attribute [r] has_verified_email
      #   @return [Boolean] whether the user's email is verified.
      property :has_verified_email

      # @!endgroup
      # @!group Logged-in user only

      # @!attribute [r] has_mail
      #   @return [Boolean] whether you have mail.
      property :has_mail

      # @!attribute [r] is_suspended
      #   @return [Boolean] whether you are suspended.
      property :is_suspended

      # @!attribute [r] has_mod_mail
      #   @return [Boolean] whether you have mod mail.
      property :has_mod_mail

      # @!attribute [r] over_18
      #   @return [Boolean] whether you have indicated you are over 18.
      property :over_18

      # @!attribute [r] gold_expiration
      #   @return [Object, nil] dunno, but nil is one of the options.
      property :gold_expiration

      # @!attribute [r] inbox_count
      #   @return [Integer] the number of unread emails.
      property :inbox_count

      # @!attribute [r] gold_creddits
      #   @return [Integer] the number of gold creddits currently owned.
      property :gold_creddits

      # @!attribute [r] suspension_expiration_utc
      #   @return [Integer, nil] if suspended, when it expires.
      property :suspension_expiration_utc

      # @!endgroup

      # @return [String] The fullname of the thing.
      def fullname
        "#{kind}_#{id}"
      end
    end
  end
end
