require 'kegbot_api/nouns/rest_noun'

module KegbotApi
  class KegSize < RestNoun
    id      :id
    string  :name
    float   :volume_ml

    def to_s
      "#<#{self.class.to_s}:#{"0x%x" % object_id} @id=#{self.id.inspect}>"
    end

    def self.to_s
      self.client ? "KegbotApi::KegSize<#{self.client.base_url}>" : super
    end

    def self.inspect
      to_s
    end
  end
end