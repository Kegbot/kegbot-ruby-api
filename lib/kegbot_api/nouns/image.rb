require 'kegbot_api/nouns/rest_noun'

module KegbotApi
  class Image < RestNoun
    id      :id
    time    :time
    url     :url
    url     :thumbnail_url

    def to_s
      "#<#{self.class.to_s}:#{"0x%x" % object_id} @id=#{self.id.inspect}>"
    end

    def self.to_s
      self.client ? "KegbotApi::Image<#{self.client.base_url}>" : super
    end

    def self.inspect
      to_s
    end
  end
end