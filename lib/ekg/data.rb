require 'faraday'
require 'json'

module Ekg
  class Data

    class << self

      def send_data(data)
        name = data[:name]
        body = build_the_body_from_the data
        send_the_body name, body
      end

      def receive_data
        response = connection.get { |req| req.url("/heartbeats.json") }
        JSON.parse(response.body).map { |x| x[1] }
      end


      private

      def build_the_body_from_the(data)
        '{ ' + data.map { |item| "\"#{item[0]}\": \"#{item[1]}\"" }.join(', ') + ' }'
      end

      def send_the_body(name, body)
        connection.patch do |req|
                           req.url "/heartbeats/#{name}.json"
                           req.body = body
                         end
      end

      def connection
        Faraday.new(:url => Ekg.config[:firebase_url]) do |faraday|
          faraday.request  :url_encoded
          faraday.response :logger
          faraday.adapter  Faraday.default_adapter
        end
      end

    end
  end
end
