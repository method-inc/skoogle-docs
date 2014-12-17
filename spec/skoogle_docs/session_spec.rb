require "helper"

describe SkoogleDocs::Session do
  subject(:session) do
    VCR.use_cassette("valid_session") do
      described_class.new(build(:client))
    end
  end

  let(:invalid_session) do
    VCR.use_cassette("invalid_session") do
      described_class.new(build(:invalid_client))
    end
  end

  let(:missing_session) do
    described_class.new(build(:blank_client))
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
