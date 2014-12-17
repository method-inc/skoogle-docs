require "helper"

describe SkoogleDocs::Client do
  subject(:client) { build(:client) }
  let(:incomplete_client) { build(:incomplete_client) }

  describe "#credentials?" do
    context "when the client has missing credentials" do
      it "returns false" do
        expect(incomplete_client.credentials?).to be_falsey
      end
    end

    context "when the client has all the credentials" do
      it "returns true" do
        expect(client.credentials?).to be_truthy
      end
    end
  end
end
