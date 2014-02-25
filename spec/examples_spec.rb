require 'spec_helper'

describe "Example Use Cases" do
  let(:default_baseurl) { TEST_API_BASEURL }
  let(:client) { KegbotApi::Client.new default_baseurl }

  it "Multiple Concurrent Clients" do
    client_1_baseurl = "https://example1.kegbot.org/api"
    client_2_baseurl = "https://example2.kegbot.org/api"

    client1 = KegbotApi::Client.new client_1_baseurl
    client2 = KegbotApi::Client.new client_2_baseurl

    # Each Tap class should have a baseurl based on the client
    expect(client1.Tap.client.base_url).to eq client_1_baseurl
    expect(client2.Tap.client.base_url).to eq client_2_baseurl
  end

  describe "Example Scripts" do
    before(:each) { FakeWeb.allow_net_connect = %r[^https?://demo\.kegbot\.org/api] }
    after(:each) { FakeWeb.allow_net_connect = nil }

    it "example_1.rb" do
      script = File.join(File.dirname(__FILE__), "example_1.rb")
      ruby = File.read(script)

      Kernel::eval(ruby, nil, script)
    end

    it "example_2.rb" do
      script = File.join(File.dirname(__FILE__), "example_2.rb")
      ruby = File.read(script)

      Kernel::eval(ruby, nil, script)
    end
  end
end