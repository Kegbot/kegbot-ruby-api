require 'spec_helper'

describe KegbotApi::Stat do
  let(:client) { KegbotApi::Client.new TEST_API_BASEURL }

  let(:attributes) do
    {"volume_by_year" => {
        "2014" => 151062,
        "2013" => 41142.0
    },
     "total_pours" => 616,
     "greatest_volume_ml" => 500.0,
     "has_guest_pour" => false,
     "registered_drinkers" => ["gus", "wusty", "harry", "t-bone"],
     "volume_by_day_of_week" => {
         "1" => 34176,
         "0" => 7784,
         "3" => 45940.0,
         "2" => 31290,
         "5" => 23213,
         "4" => 36749,
         "6" => 13052
     },
     "greatest_volume_id" => 414,
     "volume_by_drinker" => {
         "gus" => 46386.0,
         "wusty" => 54625.0,
         "t-bone" => 42212.0,
         "harry" => 48981.0
     },
     "last_drink_id" => 616,
     "sessions_count" => 66,
     "average_volume_ml" => 312.0194805194805,
     "total_volume_ml" => 192204.0
    }
  end

  describe "Class Methods" do
    describe "::all" do
      subject { client.Stat.find }

      it "not nil" do
        expect(subject).to_not be nil
      end

      it "registered_drinkers" do
        expect(subject.drinkers).to_not be_empty
      end
    end
  end

  describe "Instance Methods" do
    subject { client.Stat.new attributes }

    it "total_pours" do
      expect(subject.total_pours).to eq 616
    end

    it "registered_drinkers" do
      expect(subject.drinkers).to eq ["gus", "wusty", "harry", "t-bone"]
    end

    it "volume_by_day_of_week" do
      expect(subject.volume_by_day_of_week).to eq [["0", 7784], ["1", 34176], ["2", 31290], ["3", 45940.0], ["4", 36749], ["5", 23213], ["6", 13052]]
    end

    it "volume_by_drinker" do
      expect(subject.volume_by_drinker).to eq [["wusty", 54625.0], ["harry", 48981.0], ["gus", 46386.0], ["t-bone", 42212.0]]
    end

    it "sessions_count" do
      expect(subject.sessions_count).to eq 66
    end

    it "average_volume_ml" do
      expect(subject.average_volume_ml).to be_within(1e-6).of 312.0194805194805
    end

    it "total_volume_ml" do
      expect(subject.total_volume_ml).to be_within(1e-6).of 192204.0
    end
  end

end