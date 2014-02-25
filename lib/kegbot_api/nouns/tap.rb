require 'kegbot_api/nouns/remote_rest_noun'
require 'kegbot_api/nouns/keg'

module KegbotApi
  class Tap < RemoteRestNoun
    extend Forwardable

    id        :id
    string    :name
    string    :meter_name
    float     :ml_per_tick
    has_one   :keg, :class_name => 'Keg', :attribute_name => 'current_keg', :alias => 'current_keg'
    def_delegators :keg, :online?

    def self.all
      list(get("#{self.client.base_url}/taps"))
    end

    def to_s
      "#<#{self.class.to_s}:#{"0x%x" % object_id} @id=#{self.id.inspect}>"
    end

    def self.to_s
      self.client ? "KegbotApi::Tap<#{self.client.base_url}>" : super
    end

    def self.inspect
      to_s
    end
  end
end