require 'minitest'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ekg::Data do
  let(:firebase_url) {'https://test.firebaseio.com'}

  describe "#send_data" do
    before do
      Ekg.config = {
                     firebase_url: firebase_url
                   }
    end

    it "should fire" do
      request_body = nil
      stub_request(:patch, "#{firebase_url}/heartbeats/testing.json").
        to_return { |request| request_body = request.body; {body: ''} }
      Ekg::Data.send_data({name: 'testing', some: 'data', and: 'more'})

      request_body.must_equal "{\"name\":\"testing\",\"some\":\"data\",\"and\":\"more\"}"
    end
  end

  describe "#receive_data" do
    before do
      Ekg.config = {
                     firebase_url: firebase_url
                   }
    end

    it "should work" do
      stub_request(:get, "#{firebase_url}/heartbeats.json").
        to_return({body: '{"Ashley":{"version":"0.0.1","name":"Ashley","time":"2013-02-13 23:48:22 -0600"},"Darren":{"version":"0.0.2","name":"Darren","time":"2013-02-13 23:48:06 -0700"}}' })

      results = Ekg::Data.receive_data

      results.count.must_equal 2
      results[0].contrast_with!({ 'name' => 'Ashley', 'version' => '0.0.1', 'time' => '2013-02-13 23:48:22 -0600' })
      results[1].contrast_with!({ 'name' => 'Darren', 'version' => '0.0.2', 'time' => '2013-02-13 23:48:06 -0700' })
    end
  end
end
