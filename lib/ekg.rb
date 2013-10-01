Dir[File.dirname(__FILE__) + '/ekg/*.rb'].each {|file| require file }

module Ekg

  class << self

    attr_accessor :config

    def lub_dub
      Ekg::Data.send_data( { name:    Ekg.config[:name],
                             version: Ekg.config[:version],
                             time:    Time.now } )
    rescue
    end

    def time_since_last_heartbeat
      return nil unless time = the_last_heartbeat_time
      Time.now - time
    end

    private

    def the_last_heartbeat_time
      Time.parse the_last_heartbeat_record['time']
    rescue
      nil
    end

    def the_last_heartbeat_record
      records = Ekg::Data.receive_data
      records.select { |x| x['name'] == Ekg.config[:name] }.first
    end
  end
end
