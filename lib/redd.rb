require "redd/version"
require "redd/client/script"
require "redd/client/userless"

# The main Redd module.
module Redd
  # @overload it(:installed, client_id, redirect_uri, **kwargs)
  #   Authorize a user via an installed app.
  #   @param [String] client_id The client ID provided by reddit.
  #   @param [String] redirect_uri The exact uri you provided to reddit.
  #   @param [Hash] kwargs The keyword arguments provided to the client.
  #   @return [Client::Installed]
  #
  # @overload it(:script, client_id, secret, username, password, **kwargs)
  #   Authorize a user that you have full access to, i.e. a bot.
  #   @param [String] client_id The client ID provided by reddit.
  #   @param [String] secret The client secret provided by reddit.
  #   @param [String] username The username.
  #   @param [String] password The password of the user.
  #   @param [Hash] kwargs The keyword arguments provided to the client.
  #   @return [Client::Script]
  #
  # @overload it(:userless, client_id, secret, **kwargs)
  #   Connect to reddit from a web-app or a script without a specific user.
  #   @param [String] client_id The client ID provided by reddit.
  #   @param [String] secret The client secret provided by reddit.
  #   @param [Hash] kwargs The keyword arguments provided to the client.
  #   @return [Client::Userless]
  #
  # @overload it(:web, client_id, secret, redirect_uri, **kwargs)
  #   Authorize a user from a website.
  #   @param [String] client_id The client ID provided by reddit.
  #   @param [String] secret The client secret provided by reddit.
  #   @param [String] redirect_uri The exact uri you provided to reddit.
  #   @param [Hash] kwargs The keyword arguments provided to the client.
  #   @return [Client::Web]
  #
  def self.it(type, *args, **kwargs)
    types = {
      script: Client::Script,
      userless: Client::Userless,
      # installed: Client::Installed,
      # web: Client::Web
    }

    types[type].new(*args, **kwargs)
  end
end
