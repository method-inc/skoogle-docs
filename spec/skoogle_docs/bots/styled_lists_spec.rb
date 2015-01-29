require "spec_helper"
require "skoogle_docs/bots/shared_examples_for_bots"

RSpec.describe SkoogleDocs::Bots::StyledLists do
  subject { described_class }
  let(:dom) { build(:lists_dom) }
  directives = %w(quote definition grid)

  it_behaves_like "a bot"

  describe ".transform" do
    directives.each do |dir|
      context "when the list has the ##{dir.upcase} directive" do
        it "adds the directive name as a CSS class" do
          doc = subject.transform(dom)
          expect(doc.search(".#{dir}").size).to eq 1
        end

        it "removes the last element from the list" do
          doc = subject.transform(dom)
          list = doc.search(".#{dir} li:last").first
          expect(list.content).to_not match(/^#.*$/)
        end
      end
    end
  end
end
