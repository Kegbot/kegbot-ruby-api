require 'json'

module KegbotApi
  # Encapsulates a REST response ({Net::HTTPResponse})
  #
  # @visibility private
  class RestResponse
    # HTTP status code returned
    attr_accessor :status_code

    # result (as a string)
    attr_accessor :body

    # result (parsed into a {Hash})
    attr_accessor :body_hash

    # @overload initialize(http_response)
    #   @param http_reponse [Net::HTTPResponse]
    def initialize(*args)
      http_response = args.slice!(0)

      self.status_code = http_response.code.to_i
      self.body = http_response.read_body
    end

    def success?
      self.status_code == 200 && self.meta_result == 'ok'
    end

    # Raises an instance of {KegbotApi::Error} appropriate to the error code returned in the response
    def raise_arguments
      error_name = self.error_code
      klass = KegbotApi.const_defined?(error_name) ? KegbotApi.const_get(error_name) : KegbotApi::Error

      [klass, self.error_message]
    end

    # Parses the http result body into a {Hash}
    def body_hash
      @body_hash ||= JSON::load(self.body)
    end

    def metadata
      hash_attribute_or_fail(self.body_hash, 'meta')
    end

    def meta_result
      hash_attribute_or_fail(self.metadata, 'result')
    end

    def error
      hash_attribute_or_fail(self.body_hash, 'error')
    end

    def error_code
      hash_attribute_or_fail(self.error, 'code')
    end

    def error_message
      hash_attribute_or_fail(self.error, 'message')
      self.error['message']
    end

    def objects
      hash_attribute_or_fail(self.body_hash, 'objects')
    end

    def object
      hash_attribute_or_fail(self.body_hash, 'object')
    end

    def hash_attribute_or_fail(hash, attribute)
      (found = hash[attribute]) ? found : raise(InvalidInputError, "Server JSON response didn't include the expected '#{attribute}' field.  #{hash.inspect}")
    end
  end
end