require 'kegbot_api/nouns/remote_rest_noun'

module KegbotApi
  class Drink < RemoteRestNoun
    id      :id
    float   :volume_ml
    time    :time
    integer :duration
    has_one :keg
    has_one :session

    def self.all
      list(get("#{self.client.base_url}/drinks"))
    end

    def self.find(id, *args)
      one(get("#{self.client.base_url}/drinks/#{id}"))
    end

    def to_s
      "#<#{self.class.to_s}:#{"0x%x" % object_id} @id=#{self.id.inspect}>"
    end

    def self.to_s
      self.client ? "KegbotApi::Drink<#{self.client.base_url}>" : super
    end

    def self.inspect
      to_s
    end
  end
end