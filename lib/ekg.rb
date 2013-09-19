Dir[File.dirname(__FILE__) + '/ekg/*.rb'].each {|file| require file }

module Ekg
  class << self
    attr_accessor :config
    def lub_dub
      Ekg::Data.send_data({ name: Ekg.config[:name],
                                  version: Ekg.config[:version],
                                  time: Time.now })
    rescue
    end
  end
end
