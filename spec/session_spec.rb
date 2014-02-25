require 'spec_helper'

describe KegbotApi::Session do
  let(:client) { KegbotApi::Client.new TEST_API_BASEURL }

  describe "Class Methods" do
    let(:all) { client.Session.all }

    describe "::all" do
      describe "Is Array Like" do
        it "responds_to length" do
          expect(all).to respond_to :length
        end

        it "responds_to []" do
          expect(all).to respond_to :[]
        end
      end

      it "length == 65" do
        expect(all.length).to eq 65
      end
    end

    describe "::find(65)" do
      subject { client.Session.find 65 }

      it "Succeeds" do
        expect(subject).to_not be nil
      end

      it "id == 65" do
        expect(subject.id).to eq 65
      end

      it "raise NotFoundError on invalid ID" do
        expect { client.Session.find 999999 }.to raise_error(KegbotApi::NotFoundError)
      end
    end
  end

  describe "Instance Methods" do
    subject { client.Session.first }

    it "id == 65" do
      expect(subject.id).to eq 65
    end

    it "name == ''" do
      expect(subject.name).to eq ''
    end

    it "start_time == '2014-02-27T00:08:15+00:00'" do
      expect(subject.start_time).to eq DateTime.iso8601('2014-02-27T00:08:15+00:00').to_time
    end

    it "end_time == '2014-02-27T03:08:15+00:00'" do
      expect(subject.end_time).to eq DateTime.iso8601('2014-02-27T03:08:15+00:00').to_time
    end

    it "volume_ml == 222.0" do
      expect(subject.volume_ml).to eq 222.0
    end

    it "active? == true" do
      expect(subject).to be_active
    end

    it "to_s containts 'KegbotApi::Session'" do
      expect(subject.to_s).to include 'KegbotApi::Session'
    end
  end
end