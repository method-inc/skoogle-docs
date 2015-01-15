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

  describe "#document_by_id" do
    it "delegates the call to a SkoogleDocs::Browser instance" do
      browser = double("SkoogleDocs::Browser")
      allow(browser).to receive(:document_by_id)

      expect(client).to receive(:browser).and_return(browser)
      client.document_by_id("doc_id")
    end
  end

  describe "#documents" do
    it "delegates the call to a SkoogleDocs::Browser instance" do
      browser = double("SkoogleDocs::Browser")
      allow(browser).to receive(:documents)

      expect(client).to receive(:browser).and_return(browser)
      client.documents
    end
  end
end
