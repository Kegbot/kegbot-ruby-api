require 'spec_helper'

describe KegbotApi::Keg do
  let(:client) { KegbotApi::Client.new TEST_API_BASEURL }

  describe "Class Methods" do
    let(:all) { client.Keg.all }

    describe "::all" do
      describe "Is Array Like" do
        it "responds_to length" do
          expect(all).to respond_to :length
        end

        it "responds_to []" do
          expect(all).to respond_to :[]
        end
      end

      it "length == 4" do
        expect(all.length).to eq 4
      end

      it "first.id == 4" do
        expect(all.first.id).to eq 4
      end
    end

    describe "::find(4)" do
      subject { client.Keg.find 4 }

      it "Succeeds" do
        expect(subject).to_not be nil
      end

      it "id == 4" do
        expect(subject.id).to eq 4
      end

      it "raise NotFoundError on invalid ID" do
        expect { client.Keg.find 999999 }.to raise_error(KegbotApi::NotFoundError)
      end
    end
  end

  describe "Instance Methods" do
    subject { client.Keg.first }

    it "id == 4" do
      expect(subject.id).to eq 4
    end

    it "percent_full == 37.149226487416044" do
      expect(subject.percent_full).to be_within(1e-6).of 37.149226487416044
    end

    it "volume_ml_remain == 21796.9" do
      expect(subject.volume_ml_remain).to be_within(1e-6).of 21796.9
      expect(subject.volume_ml_remaining).to be_within(1e-6).of 21796.9
    end

    it "spilled_ml == 0.0" do
      expect(subject.spilled_ml).to be_within(1e-6).of 0.0
    end

    it "start_time == '2014-01-31T23:11:42+00:00'" do
      expect(subject.start_time).to eq DateTime.iso8601('2014-01-31T23:11:42+00:00').to_time
    end

    it "start_time is Time" do
      expect(subject.start_time).to be_kind_of Time
    end

    it "end_time == '2014-01-31T23:11:42+00:00'" do
      expect(subject.end_time).to eq DateTime.iso8601('2014-01-31T23:11:42+00:00').to_time
    end

    it "end_time is Time" do
      expect(subject.end_time).to be_kind_of Time
    end

    it "online? == true" do
      expect(subject).to be_online
    end

    it "name == 'Drake's 1500'" do
      expect(subject.name).to eq "Drake's 1500"
    end

    it "volume_ml == 58673.9" do
      expect(subject.volume_ml).to eq 58673.9
    end

    it "size_name == 'half-barrel'" do
      expect(subject.size_name).to eq "half-barrel"
    end

    it "to_s containts 'KegbotApi::Keg'" do
      expect(subject.to_s).to include 'KegbotApi::Keg'
    end
  end

  describe "Associations" do
    describe "type/beverage" do
      subject { client.Keg.first }

      it "Works" do
        expect(subject.beverage).to_not be nil
      end

      it "aka type" do
        expect(subject.type).to_not be nil
      end

      it "beverage.name" do
        expect(subject.beverage.name).to_not be nil
      end
    end

    describe "size" do
      subject { client.Keg.first }

      it "Works" do
        expect(subject.size).to_not be nil
      end
    end
  end

  pending "keg.drinks"
  pending "keg.sessions"
end