require 'spec_helper'

describe KegbotApi::User do
  let(:client) { KegbotApi::Client.new TEST_API_BASEURL, :api_key => TEST_API_KEY }
  let(:attributes) do
    {
        "username"=>"gus",
        "first_name"=>"gus first",
        "last_name"=>"gus last",
        "url"=>"/drinkers/gus/",
        "image"=> {
            "url"=>"/media/CACHE/images/pics/20140131231052-84ace2243a304d3095ff12b85eb14ddc/fd54502eff326e838f3134d97951051c.jpg",
            "thumbnail_url"=>"/media/CACHE/images/pics/20140131231052-84ace2243a304d3095ff12b85eb14ddc/3718ef57dbbffe3a1f64cad02ea6609d.jpg",
            "user_id"=>"gus",
            "original_url"=>"/media/pics/20140131231052-84ace2243a304d3095ff12b85eb14ddc.e",
            "time"=>"2014-01-31T23:10:52+00:00"
        },
        "is_active"=>true,
        "is_superuser"=>true,
        "is_staff"=>true,
        "last_login"=>"2014-02-20T01:27:36+00:00",
        "email"=>"gus@demo.kegbot.org",
        "date_joined"=>"2014-01-31T23:10:52+00:00"
    }
  end

  describe "Class Methods" do
    describe "::all" do
      let(:all) { client.User.all }

      it "length == 4" do
        expect(all.length).to eq 4
      end

      # Includes each of the expected users
      ['gus', 'harry', 't-bone', 'wusty'].each do |username|
        it "Returned '#{username}'" do
          expect(all.any? {|u| u.username == username }).to eq true
        end
      end
    end

    describe "::find('gus')" do
      subject { client.User.find 'gus' }

      it "Returns 'gus'" do
        expect(subject.username).to eq 'gus'
      end
    end

    it "Fails when no-auth" do
      expect { client.User.find 'noauth' }.to raise_error(KegbotApi::Error)
    end
  end

  describe "Instance Methods" do
    describe "Attributes 1" do
      subject { client.User.new attributes }

      {
          :username => 'gus',
          :first_name => 'gus first',
          :last_name => 'gus last',
          :active? => true,
          :superuser? => true,
          :staff? => true,
          :email => 'gus@demo.kegbot.org',
          :last_login => DateTime.iso8601('2014-02-20T01:27:36+00:00').to_time,
          :date_joined => DateTime.iso8601('2014-01-31T23:10:52+00:00').to_time,
      }
      .each_pair do |attribute, expected_value|
        it "#{attribute} == #{expected_value}" do
          expect(subject.send(attribute)).to eq expected_value
        end
      end
    end

    describe "Attributes 2" do
      let(:attributes2) do
        cloned = attributes.clone

        cloned['is_active'] = false
        cloned['is_superuser'] = false
        cloned['is_staff'] = false

        cloned
      end
      subject { client.User.new attributes2 }

      {
          :active? => false,
          :staff? => false,
          :superuser? => false
      }
      .each_pair do |attribute, expected_value|
        it "#{attribute} == #{expected_value}" do
          expect(subject.send(attribute.to_sym)).to eq expected_value
        end
      end
    end
  end

  describe "Associations" do
    subject { client.User.new attributes }

    describe "image" do
      it "not nil" do
        expect(subject.image).to_not be nil
      end

      it 'url' do
        expect(subject.image.url).to eq 'https://example.kegbot.org/media/CACHE/images/pics/20140131231052-84ace2243a304d3095ff12b85eb14ddc/fd54502eff326e838f3134d97951051c.jpg'
      end

      it 'thumbnail_url' do
        expect(subject.image.thumbnail_url).to eq 'https://example.kegbot.org/media/CACHE/images/pics/20140131231052-84ace2243a304d3095ff12b85eb14ddc/3718ef57dbbffe3a1f64cad02ea6609d.jpg'
      end
    end
  end
end