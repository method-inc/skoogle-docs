require "helper"

describe SkoogleDocs::Config do
  subject(:config) { build(:config) }
  let(:incomplete_config) { build(:incomplete_config) }

  describe "#credentials?" do
    context "when there are missing credentials" do
      it "returns false" do
        expect(incomplete_config.credentials?).to be_falsey
      end
    end

    context "when all credentials are present" do
      it "returns true" do
        expect(config.credentials?).to be_truthy
      end
    end
  end

  describe "#credentials" do
    it "returns a hash with all credentials" do
      expect(config.credentials).to be_a Hash
    end
  end

  describe "#application_info" do
    it "returns a hash with the application info" do
      expect(config.application_info).to be_a Hash
    end
  end
end
