require 'kegbot_api/nouns/remote_rest_noun'

module KegbotApi
  class User < RemoteRestNoun
    string  :username
    string  :first_name
    string  :last_name
    boolean :active, :attribute_name => :is_active
    boolean :superuser, :attribute_name => :is_superuser
    boolean :staff, :attribute_name => :is_staff
    time    :last_login
    time    :date_joined
    string  :email
    has_one :image

    def id
      self.username
    end

    def self.all
      list(get("#{self.client.base_url}/users"))
    end

    def self.find(id, *args)
      one(get("#{self.client.base_url}/users/#{id}"))
    end

    def to_s
      "#<#{self.class.to_s}:#{"0x%x" % object_id} @id=#{self.id.inspect}>"
    end

    def self.to_s
      self.client ? "KegbotApi::User<#{self.client.base_url}>" : super
    end

    def self.inspect
      to_s
    end
  end
end