require 'kegbot_api/nouns/remote_rest_noun'

module KegbotApi
  # Summary statistics provided by the /stats API endpoint
  #
  # <b>Example:</b>
  #
  # {include:file:spec/example_3.rb}
  class Stat < RemoteRestNoun
    float   :total_pours
    raw     :drinkers, :attribute_name => :registered_drinkers
    integer :sessions_count, :alias => :session_count
    float   :average_volume_ml
    float   :total_volume_ml

    def id
      'n/a'
    end

    # @return [Array] Array of [day of week index, volume_ml], in ascending day of week order
    def volume_by_day_of_week
      self.attributes['volume_by_day_of_week'].to_a.sort {|a,b| a.first <=> b.first }
    end

    # @return [Array] Array of pairs [username, volume_ml] for each user, in descending volume order
    def volume_by_drinker
      self.attributes['volume_by_drinker'].to_a.sort {|a,b| b.last <=> a.last }
    end

    # Returns all stats (unlike other +all+ methods, this is a single hash_like object, not a list)
    def self.all
      one(get("#{self.client.base_url}/stats"))
    end

    # Returns stat information
    # @param id [Integer] (unused)
    def self.find(id = 0, *args)
      all
    end

    def to_s
      "#<#{self.class.to_s}:#{"0x%x" % object_id} @id=#{self.id.inspect}>"
    end

    def self.to_s
      self.client ? "KegbotApi::Stat<#{self.client.base_url}>" : super
    end

    def self.inspect
      to_s
    end
  end
end