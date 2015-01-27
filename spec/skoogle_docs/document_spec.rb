require "spec_helper"

RSpec.describe SkoogleDocs::Document do
  subject(:document) { build(:document) }

  describe "#source" do
    it "holds a String value" do
      expect(document.source).to be_a String
    end
  end

  describe "#source=" do
    it "can set the value" do
      source = Faker::Lorem.paragraph
      document.source = source
      expect(document.source).to eq source
    end
  end

  describe "#transform" do
    it "delegates the call to a SkoogleDocs::Transformer instance" do
      transformer = double("SkoogleDocs::Transformer")
      allow(transformer).to receive(:rollout)

      expect(document).to receive(:transformer).and_return(transformer)
      document.transform
    end
  end
end
