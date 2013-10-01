require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Ekg do

  describe "#lub_dub" do
    [:name, :version].to_hashes {[
      ['a name', '1.0'],
      ['another name', '2.0']
    ]}.each do |test|
      describe "sending data" do
        before do
          time = Timecop.freeze
          Ekg::Data.expects(:send_data).with do |data|
            data[:name] == test[:name] and
            data[:version] == test[:version] and
            data[:time] == time
          end

          Ekg.config = test
          Ekg.lub_dub
        end

        after do
          Timecop.return
        end

        it "should post the data about the service" do
          # asserted above
        end
      end
    end

    it "should eat all errors" do
      time = Timecop.freeze
      Ekg::Data.stubs(:send_data).raises
      Ekg.config = {}
      Ekg.lub_dub
      # an error should not bubble up
    end
  end

  describe "time_since_last_heartbeat" do
    [:now, :seconds_ago].to_objects { [
      ["2013-09-30 21:53:56 -0500", 1],
      ["2012-09-30 20:50:00 -0600", 2]
    ] }.each do |test|
      describe "when the heartbeat was seconds ago" do
        before do

          Timecop.freeze Time.parse(test.now)

          Ekg.config = {
                         name: 'test',
                       }

          Ekg::Data.stubs(:receive_data)
                   .returns([ { 'name' => 'test', 
                                'time' => (Time.now - test.seconds_ago).to_s } ])
        end

        it "should return the difference in seconds" do
          Ekg.time_since_last_heartbeat.must_equal test.seconds_ago
        end

      end
    end
  end
end
