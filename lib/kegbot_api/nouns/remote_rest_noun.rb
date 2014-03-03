require 'active_support/concern'
require 'kegbot_api/nouns/rest_noun'

module KegbotApi
  # Rest noun that supports remote access via {#all} and {#find}
  class RemoteRestNoun < RestNoun

    #
    # Class Methods
    #

    class << self
      def list(response)
        if response.success?
          response.objects.map { |hash| self.new hash }
        else
          raise *response.raise_arguments
        end
      end

      def one(response)
        if response.success?
          self.new response.object
        else
          raise *response.raise_arguments
        end
      end

      def first
        all.first
      end

      def get(url, options = {})
        uri = URI(url)

        Net::HTTP.start(uri.host, uri.port, :use_ssl => (uri.scheme == 'https')) do |http|

          headers = {}
          headers.merge!({ 'X-Kegbot-Api-Key' => self.client.api_key }) if self.client.api_key?

          http_response = http.request_get uri.request_uri, headers

          case http_response
            when Net::HTTPRedirection
              raise NotImplementedError, "HTTP redirecting isn't supported"
            else
              RestResponse.new http_response
          end
        end
      end
    end
  end
end