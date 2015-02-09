require "spec_helper"

RSpec.describe SkoogleDocs::Bots::Bot do
  subject { described_class }
  let(:dom) { build(:mini_dom) }

  describe ".all" do
    it "does not return nil" do
      bots = subject.all
      expect(bots).not_to be_nil
    end

    it "returns an Array" do
      bots = subject.all
      expect(bots).to be_a Array
    end

    it "is not an empty Array" do
      bots = subject.all
      expect(bots).not_to be_empty
    end

    it "returns Bot instances" do
      bots = subject.all
      expect(bots.all? { |b| b <= subject }).to be_truthy
    end
  end

  describe ".html" do
    it "returns a Nokogiri::XML::Element" do
      expect(subject.html(dom)).to be_a Nokogiri::XML::Element
    end

    it "returns an html element" do
      expect(subject.html(dom).name).to eq "html"
    end
  end

  describe ".head" do
    it "returns a Nokogiri::XML::Element" do
      expect(subject.head(dom)).to be_a Nokogiri::XML::Element
    end

    it "returns an head element" do
      expect(subject.head(dom).name).to eq "head"
    end
  end

  describe ".body" do
    it "returns a Nokogiri::XML::Element" do
      expect(subject.body(dom)).to be_a Nokogiri::XML::Element
    end

    it "returns an body element" do
      expect(subject.body(dom).name).to eq "body"
    end
  end
end
