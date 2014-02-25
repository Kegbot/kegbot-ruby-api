require 'spec_helper'

describe KegbotApi::Beverage do
  let(:client) { KegbotApi::Client.new TEST_API_BASEURL }
  let(:attributes) do
    {"name"=>"Anchor Steam",
     "style_id"=>"0",
     "image"=>
         {"url"=>
              "/media/CACHE/images/pics/20140131231053-a36a6b7cd54d461c97c63339c6762bf0/c7a226b5122af9ea4c3b9d72cdc4c46d.jpg",
          "thumbnail_url"=>
              "/media/CACHE/images/pics/20140131231053-a36a6b7cd54d461c97c63339c6762bf0/704675543d5b73232c8a51f16435ea9d.jpg",
          "original_url"=>
              "/media/pics/20140131231053-a36a6b7cd54d461c97c63339c6762bf0.e",
          "time"=>"2014-01-31T23:10:53+00:00"},
     "abv"=>0.0,
     "brewer_id"=>"1",
     "id"=>"1"}
  end

  describe "Instance Methods" do
    subject { client.Beverage.new attributes }

    it "name" do
      expect(subject.name).to eq 'Anchor Steam'
    end

    it "abv" do
      expect(subject.abv).to eq 0.0
    end

    it "to_s container 'KegbotApi::Beverage'" do
      expect(subject.to_s).to include 'KegbotApi::Beverage'
    end
  end

  describe "Associations" do
    subject { client.Beverage.new attributes }

    it "image" do
      expect(subject.image).to_not be nil
    end
  end
end