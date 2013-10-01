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
      records = Ekg::Data.receive_data
      record = records.select { |x| x['name'] == Ekg.config[:name] }[0]
      Time.now - Time.parse(record['time'])
    end

  end

end
