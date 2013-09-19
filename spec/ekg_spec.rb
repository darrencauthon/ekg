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
end
