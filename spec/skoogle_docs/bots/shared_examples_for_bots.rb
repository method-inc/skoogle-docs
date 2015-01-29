require "spec_helper"

RSpec.shared_examples "a bot" do
  subject { described_class }
  doms = [
    ["is empty", FactoryGirl.build(:empty_dom)],
    ["has no head element", FactoryGirl.build(:no_head_dom)],
    ["has no body element", FactoryGirl.build(:no_body_dom)],
    ["is a small valid html document", FactoryGirl.build(:mini_dom)],
    ["is a full valid html document", FactoryGirl.build(:dom)]
  ]

  describe ".transform" do
    doms.each do |data|
      let(:doc) { subject.transform(data[1]) }

      context "when the dom #{data[0]}" do
        it "returns a Nokogiri::HTML::Document object" do
          expect(doc).to be_a Nokogiri::HTML::Document
        end

        it "contains a single html element" do
          expect(doc.search("html").size).to eq 1
        end

        it "contains a single head element" do
          expect(doc.search("head").size).to eq 1
        end

        it "contains a single body element" do
          expect(doc.search("body").size).to eq 1
        end
      end
    end
  end
end
