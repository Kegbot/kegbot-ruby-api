require 'spec_helper'

describe KegbotApi::Tap do
  let(:client) { KegbotApi::Client.new TEST_API_BASEURL }
  let(:attributes) do
    {
        "meter_name" => "kegboard.flow0",
        "name" => "Main Tap",
        "ml_per_tick" => 0.185185185185185,
        "relay_name" => "",
        "current_keg" => {
            "volume_ml_remain" => 21796.9,
            "type_id" => "4",
            "url" => "/kegs/4",
            "spilled_ml" => 0.0,
            "start_time" => "2014-01-31T23:11:42+00:00",
            "percent_full" => 37.149226487416044,
            "id" => 4, "size_name" =>
                "half-barrel",
            "end_time" => "2014-01-31T23:11:42+00:00",
            "online" => true,
            "type" => {
                "name" => "Drake's 1500",
                "style_id" => "0",
                "image" => {
                    "url" => "/media/CACHE/images/pics/20140131231053-e6ce61eda0a841edad856fe2679c8f90/0d8521a4eef37663218db5aef284089e.jpg",
                    "thumbnail_url" => "/media/CACHE/images/pics/20140131231053-e6ce61eda0a841edad856fe2679c8f90/1c3f0a2375704ebe62a82aec658b5287.jpg",
                    "time" => "2014-01-31T23:10:53+00:00",
                    "original_url" => "/media/pics/20140131231053-e6ce61eda0a841edad856fe2679c8f90.e"
                },
                "abv" => 0.0,
                "brewer_id" => "3",
                "id" => "4"
            },
            "size_id" => 0,
            "size_volume_ml" => 58673.9,
            "size" => {
                "volume_ml" => 58673.9,
                "id" => 0,
                "name" => "half-barrel"
            }
        },
        "current_keg_id" => 4,
        "id" => 1
    }
  end
  let(:attributes2) do
    cloned = attributes
    cloned['current_keg']['online'] = false

    cloned
  end
  subject { client.Tap.new attributes }

  describe "Class Methods" do
    let(:all) { client.Tap.all }

    describe "::all" do
      describe "Is Array Like" do
        it "responds_to length" do
          expect(all).to respond_to :length
        end

        it "responds_to []" do
          expect(all).to respond_to :[]
        end
      end

      it "length == 2" do
        expect(all.length).to eq 2
      end

      it "first.id == 1" do
        expect(all.first.id).to eq 1
      end
    end
  end

  describe "Instance Methods" do
    describe "Example 1" do
      it "id == 1" do
        expect(subject.id).to eq 1
      end

      it "name == 'Main Tap'" do
        expect(subject.name).to eq 'Main Tap'
      end

      it "meter_name == ''" do
        expect(subject.meter_name).to eq 'kegboard.flow0'
      end

      it "ml_per_tick == '0.185185185185185'" do
        expect(subject.ml_per_tick).to be_within(1e-6).of(0.185185185185185)
      end

      it "online? == true" do
        expect(subject.online?).to be true
      end

      it "to_s containts 'KegbotApi::Tap'" do
        expect(subject.to_s).to include 'KegbotApi::Tap'
      end
    end

    describe "Example 2" do
      subject { client.Tap.new attributes2 }

      it "online? == false" do
        expect(subject.online?).to be false
      end
    end
  end

  describe "Associations" do
    subject { client.Tap.first }

    describe "keg" do
      it "Returns a Keg" do
        expect(subject.keg).to_not be nil
      end

      it "keg.id == 4" do
        expect(subject.keg.id).to eq 4
      end

      it "current_keg also works" do
        expect(subject.current_keg.id).to eq 4
      end
    end
  end

  pending "tap.find"
end