require 'kegbot_api/nouns/remote_rest_noun'

module KegbotApi
  class Keg < RemoteRestNoun
    extend Forwardable

    id      :id
    float   :percent_full
    float   :volume_ml_remain, :alias => :volume_ml_remaining
    float   :spilled_ml
    time    :start_time
    time    :end_time
    boolean :online
    has_one :beverage, :attribute_name => :type, :alias => :type
    has_one :size, :class_name => 'KegSize'

    def_delegators :beverage, :name
    def_delegators :size, :volume_ml


    def size_name
      self.size.name
    end

    def self.all
      list(get("#{self.client.base_url}/kegs"))
    end

    def self.find(id, *args)
      one(get("#{self.client.base_url}/kegs/#{id}"))
    end

    def to_s
      "#<#{self.class.to_s}:#{"0x%x" % object_id} @id=#{self.id.inspect}>"
    end

    def self.to_s
      self.client ? "KegbotApi::Keg<#{self.client.base_url}>" : super
    end

    def self.inspect
      to_s
    end
  end
end