require "redd/api/thing"

module Redd
  module API
    # The model for a reddit user.
    class User < Thing
      # @!group All users

      # @return [String] the username.
      property :name

      # @return [Boolean] whether the user is your friend.
      property :is_friend

      # @return [Integer] the epoch time of creation.
      # @note Prefer created_utc, apparently it's more accurate.
      # @todo convert to Time.
      property :created

      # @return [Boolean] whether the user prefers to hide from search.
      property :hide_from_robots

      # @return [Integer] the epoch time of creation, in UTC time.
      # @todo convert to Time.
      property :created_utc

      # @return [Integer] the amount of link karma.
      property :link_karma

      # @return [Integer] the amount of comment karma.
      property :comment_karma

      # @return [Boolean] whether the user has gold.
      property :is_gold

      # @return [Boolean] whether the user is a moderator of a subreddit.
      property :is_mod

      # @return [Boolean] whether the user's email is verified.
      property :has_verified_email

      # @!endgroup
      # @!group Logged-in user only

      # @return [Boolean] whether you have mail.
      property :has_mail

      # @return [Boolean] whether you are suspended.
      property :is_suspended

      # @return [Boolean] whether you have mod mail.
      property :has_mod_mail

      # @return [Boolean] whether you have indicated you are over 18.
      property :over_18

      # @return [Object, nil] dunno, but nil is one of the options.
      property :gold_expiration

      # @return [Integer] the number of unread emails.
      property :inbox_count

      # @return [Integer] the number of gold creddits currently owned.
      property :gold_creddits

      # @return [Integer, nil] if suspended, when it expires.
      property :suspension_expiration_utc

      # @!endgroup

      # @return [String] The fullname of the thing.
      def fullname
        "#{kind}_#{id}"
      end
    end
  end
end
