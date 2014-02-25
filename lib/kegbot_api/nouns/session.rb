require 'kegbot_api/nouns/remote_rest_noun'

module KegbotApi
  class Session < RemoteRestNoun
    id      :id
    string  :name
    time    :start_time
    time    :end_time
    boolean :active, :attribute_name => 'is_active'
    float   :volume_ml

    def self.all
      list(get("#{self.client.base_url}/sessions"))
    end

    def self.find(id, *args)
      one(get("#{self.client.base_url}/sessions/#{id}"))
    end

    def to_s
      "#<#{self.class.to_s}:#{"0x%x" % object_id} @id=#{self.id.inspect}>"
    end

    def self.to_s
      self.client ? "KegbotApi::Session<#{self.client.base_url}>" : super
    end

    def self.inspect
      to_s
    end
  end
end