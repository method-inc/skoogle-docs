require "spec_helper"

describe SkoogleDocs::Client do
  subject(:client) { build(:client) }
  let(:blank_client) { build(:blank_client) }

  describe "#new" do
    context "when the configuration is empty" do
      it "raises a SkoogleDocs::Errors::BadAuthenticationData error" do
        expected = expect { blank_client }
        expected.to raise_error SkoogleDocs::Errors::BadAuthenticationData
      end
    end

    context "when the configuration is complete" do
      it "returns a SkoogleDocs::Client instance" do
        expect(client).to be_a described_class
      end
    end
  end

  describe "#config" do
    it "holds a SkoogleDocs::Configuration instance" do
      expect(client.config).to be_a SkoogleDocs::Configuration
    end
  end

  describe "#config=" do
    it "can set the value" do
      config = double("SkoogleDocs::Configuration")
      client.config = config
      expect(client.config).to eq config
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
