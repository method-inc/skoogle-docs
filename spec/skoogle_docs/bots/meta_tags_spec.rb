require "spec_helper"
require "skoogle_docs/bots/shared_examples_for_bots"

RSpec.describe SkoogleDocs::Bots::MetaTags do
  subject { described_class }
  let(:dom) { build(:mini_dom) }

  it_behaves_like "a bot"

  describe ".transform" do
    it "sets UTF-8 as the meta tag encodig" do
      doc = subject.transform(dom)
      expect(doc.meta_encoding.to_s).to eq described_class::METAS[0]
    end
  end
end
