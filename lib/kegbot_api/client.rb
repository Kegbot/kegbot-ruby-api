require 'kegbot_api/client_helpers'
require 'kegbot_api/nouns/keg'
require 'kegbot_api/nouns/tap'
require 'kegbot_api/nouns/drink'
require 'kegbot_api/nouns/session'
require 'kegbot_api/nouns/beverage'
require 'kegbot_api/nouns/image'
require 'kegbot_api/nouns/keg_size'

module KegbotApi
  # Represents a connection to a specific Kegbot REST server
  #
  # Because a program my want to access multiple Kegbot REST APIs servers from the same program, you can create a {Client}
  # instance appropriate for each server.  To get an instance of a REST noun ({Drink}, {Keg}, {Tap}, etc.) connected to
  # this client, use the appropriate methods below. {#Drink}
  class Client
    include ClientHelpers

    attr_accessor :base_url
    attr_accessor :api_key

    # @param base_url [String] base URL for the REST server (ie: http://demo.kegbot.org/api)
    # @param options [Hash] (currently unused)
    # @option options [String] +:api_key+ API authentication token
    def initialize(base_url, options = {})
      self.base_url = base_url
      self.api_key = options[:api_key]
    end

    def api_key?
      !!self.api_key
    end

    # @!macro [attach] rest_noun
    #   @!method $1
    #   @return [$1] $1 class (specialized for this specific client instance)
    noun Drink
    noun Tap
    noun Keg
    noun Session
    noun Session
    noun Beverage
    noun Image
    noun KegSize
  end
end