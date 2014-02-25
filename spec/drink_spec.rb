require 'spec_helper'

describe KegbotApi::Drink do
  let(:client) { KegbotApi::Client.new TEST_API_BASEURL }

  describe "Class Methods" do
    let(:all) { client.Drink.all }

    describe "::all" do
      describe "Is Array Like" do
        it "responds_to length" do
          expect(all).to respond_to :length
        end

        it "responds_to []" do
          expect(all).to respond_to :[]
        end
      end

      it "length == 100" do
        expect(all.length).to eq 100
      end
    end

    describe "::find(614)" do
      subject { client.Drink.find 614 }

      it "Succeeds" do
        expect(subject).to_not be nil
      end

      it "id == 614" do
        expect(subject.id).to eq 614
      end

      it "raise NotFoundError on invalid ID" do
        expect { client.Drink.find 999999 }.to raise_error(KegbotApi::NotFoundError)
      end
    end
  end

  describe "Instance Methods" do
    subject { client.Drink.first }

    it "id == 614" do
      expect(subject.id).to eq 614
    end

    it "volume_ml == 222.0" do
      expect(subject.volume_ml).to eq 222.0
    end

    it "time == '2014-02-27T00:08:15+00:00'" do
      expect(subject.time).to eq DateTime.iso8601('2014-02-27T00:08:15+00:00').to_time
    end

    it "duration == 0" do
      expect(subject.duration).to eq 0
    end

    it "to_s containts 'KegbotApi::Drink'" do
      expect(subject.to_s).to include 'KegbotApi::Drink'
    end
  end

  describe "Associations" do
    subject { client.Drink.first }

    describe "keg" do
      it "Not nil" do
        expect(subject.keg).to_not be nil
      end

      it "keg.id == 3" do
        expect(subject.keg.id).to eq 3
      end
    end

    describe "session" do
      it "Not nil" do
        expect(subject.session).to_not be nil
      end
    end
  end

  pending "drink.images"
  pending "drink.user"
end