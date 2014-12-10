require "helper"
require "skoogle_docs/doc"

describe SkoogleDocs::Doc do
  subject(:session) do
    VCR.use_cassette("test") do
      SkoogleDocs::Doc.new("1YPYsTsedEQXJztXOtPcPkdiy16ow8P4c0DXzHKcaB7A")
    end
  end

  let(:doc) do
    VCR.use_cassette("blah") do
      session.latest_from_google
    end
  end

  it "does something" do
    expect(doc.title).to eq "Skoogle Docs"
  end
end

