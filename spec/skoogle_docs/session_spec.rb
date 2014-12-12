require "helper"

describe SkoogleDocs::Session do
  subject(:session) do
    VCR.use_cassette("valid_session") do
      described_class.new(valid_client)
    end
  end

  let(:invalid_session) do
    VCR.use_cassette("invalid_session") do
      described_class.new(invalid_client)
    end
  end

  let(:missing_session) do
    described_class.new(SkoogleDocs::Client.new)
  end

  let(:valid_client) do
    SkoogleDocs::Client.new do |config|
      config.client_id     = ENV["CLIENT_ID"]
      config.client_secret = ENV["CLIENT_SECRET"]
      config.access_token  = ENV["CLIENT_TOKEN"]
    end
  end

  let(:invalid_client) do
    SkoogleDocs::Client.new do |config|
      config.client_id     = "invalid"
      config.client_secret = "invalid"
      config.access_token  = "invalid"
    end
  end

  describe "#new" do
    context "when Google Drive credentials are missing" do
      it "raises a BadAuthenticationData error" do
        expected = expect { missing_session }
        expected.to raise_error SkoogleDocs::Errors::BadAuthenticationData
      end
    end

    context "when Google Drive credentials are invalid" do
      it "raises an Unauthorized error" do
        expected = expect { invalid_session }
        expected.to raise_error SkoogleDocs::Errors::AuthorizationError
      end
    end

    context "when Google Drive credentials are valid" do
      it "returns a Skoogle Docs session" do
        expect(session).to_not be_nil
      end
    end
  end
end
