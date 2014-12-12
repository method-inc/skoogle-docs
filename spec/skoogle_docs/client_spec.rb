require "helper"

describe SkoogleDocs::Client do
  subject(:client) do
    described_class.new do |config|
      config.client_id     = ENV["CLIENT_ID"]
      config.client_secret = ENV["CLIENT_SECRET"]
      config.access_token  = ENV["CLIENT_TOKEN"]
    end
  end

  let(:invalid_client) do
    described_class.new do |config|
      config.client_id = ENV["CLIENT_ID"]
    end
  end

  describe "#credentials?" do
    context "when the client has missing credentials" do
      it "returns false" do
        expect(invalid_client.credentials?).to be_falsey
      end
    end

    context "when the client has all the credentials" do
      it "returns true" do
        expect(client.credentials?).to be_truthy
      end
    end
  end
end
