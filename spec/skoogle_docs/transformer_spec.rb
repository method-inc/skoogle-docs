require "spec_helper"

RSpec.describe SkoogleDocs::Transformer do
  subject(:transformer) { build(:transformer) }

  describe "#rollout" do
    it "returns a String" do
      expect(transformer.rollout).to be_a String
    end
  end
end
