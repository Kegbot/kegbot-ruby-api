require 'spec_helper'

describe KegbotApi::Image do
  let(:client) { KegbotApi::Client.new TEST_API_BASEURL }
  let(:attributes) do
    {
        "url" => "/media/CACHE/images/pics/20140131231053-e6ce61eda0a841edad856fe2679c8f90/0d8521a4eef37663218db5aef284089e.jpg",
        "thumbnail_url" => "/media/CACHE/images/pics/20140131231053-e6ce61eda0a841edad856fe2679c8f90/1c3f0a2375704ebe62a82aec658b5287.jpg",
        "original_url" => "/media/pics/20140131231053-e6ce61eda0a841edad856fe2679c8f90.e",
        "time" => "2014-01-31T23:10:53+00:00"
    }
  end

  describe "Image Methods" do
    subject { client.Image.new attributes }

    it "time" do
      expect(subject.time).to eq DateTime.iso8601("2014-01-31T23:10:53+00:00").to_time
    end

    it "url" do
      expect(subject.url).to eq 'https://example.kegbot.org/media/CACHE/images/pics/20140131231053-e6ce61eda0a841edad856fe2679c8f90/0d8521a4eef37663218db5aef284089e.jpg'
    end

    it "thumbnail_url" do
      expect(subject.thumbnail_url).to eq 'https://example.kegbot.org/media/CACHE/images/pics/20140131231053-e6ce61eda0a841edad856fe2679c8f90/1c3f0a2375704ebe62a82aec658b5287.jpg'
    end

    it "to_s container 'KegbotApi::Image'" do
      expect(subject.to_s).to include 'KegbotApi::Image'
    end
  end
end