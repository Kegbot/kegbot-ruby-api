require 'net/https'
require 'kegbot_api/rest_response'
require 'kegbot_api/nouns/rest_noun_attributes'

module KegbotApi
  # Base class of all REST nouns (types) in the Kegbot REST API.
  class RestNoun
    include RestNounAttributes

    def initialize(attributes = {})
      self.attributes = attributes
    end

    # Returns a {Client} client configured for this class
    # @return [Client]
    def client
      self.class.client
    end

    # Class Methods

    class << self
      # @return [Client]
      attr_accessor :client
      attr_accessor :noun

      def client=(client)
        @client = client
      end

      def client
        @client
      end
    end
  end
end