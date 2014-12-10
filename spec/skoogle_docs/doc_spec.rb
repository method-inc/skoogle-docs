require "helper"
require "skoogle_docs/doc"

describe SkoogleDocs::Doc do
  subject(:doc) do
    VCR.use_cassette("test") do
      SkoogleDocs::Doc.new("1YPYsTsedEQXJztXOtPcPkdiy16ow8P4c0DXzHKcaB7A")
    end
  end

  it "does something" do
    expect(doc.latest_from_google.title).to eq "Skoogle Docs"
  end
end

