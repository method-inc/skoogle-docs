require "spec_helper"
require "skoogle_docs/bots/shared_examples_for_bots"

RSpec.describe SkoogleDocs::Bots::DoctypeTag do
  subject { described_class }
  let(:dom) { build(:mini_dom) }

  it_behaves_like "a bot"

  describe ".transform" do
    it "has an HTML5 document type declaration" do
      doc = subject.transform(dom)
      expect(doc.internal_subset.html5_dtd?).to be_truthy
    end
  end
end
