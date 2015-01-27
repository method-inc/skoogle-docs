require "spec_helper"

RSpec.describe SkoogleDocs::Session do
  subject(:session) { build(:session) }
  let(:invalid_session) { build(:invalid_session) }
  let(:blank_session) { build(:blank_session) }

  describe "#new" do
    context "when Google Drive credentials are missing" do
      it "raises a BadAuthenticationData error" do
        expected = expect { blank_session }
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
