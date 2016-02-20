module Redd
  # A rate limiter that sleeps. Great for bots, but not for web services.
  # @note Seriously though, look into concurrency gems if you want to perform
  #   any sort of API calls in your web services.
  class RateLimit
    # Create a rate limiter.
    # @param [Numeric] gap a backup value if rate limiting is unavailable.
    def initialize(gap = 1)
      @gap = gap
      @last_request = Time.at(0)
      @reset = 0
      @remaining = 0
    end

    # Wait if needed and run the block.
    # @yield the request to make.
    # @yieldreturn [Response] the API response.
    # @todo Document response type.
    def after_limit
      sleep(wait_time)
      response = yield
      update(response)
      response
    end

    private

    # The time to wait before each request.
    def wait_time
      if @reset.nil? || @remaining.nil?
        time = @last_request_time - Time.now + @gap
        time > 0 ? time : 0
      else
        @reset.fdiv(@remaining + 1)
      end
    end

    # Update the instance variables with the response headers.
    def update(response)
      @last_request_time = Time.now
      @reset = response.headers["x-ratelimit-reset"]
      @remaining = response.headers["x-ratelimit-remaining"]
    end
  end
end
