require 'kegbot_api/nouns/rest_noun'

module KegbotApi
  # Beverage information (as returned with a {Keg} instance)
  class Beverage < RemoteRestNoun
    id      :id
    string  :name
    float   :abv
    has_one :image

    def to_s
      "#<#{self.class.to_s}:#{"0x%x" % object_id} @id=#{self.id.inspect}>"
    end

    def self.to_s
      self.client ? "KegbotApi::Beverage<#{self.client.base_url}>" : super
    end

    def self.inspect
      to_s
    end
  end
end