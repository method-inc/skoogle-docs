DOCUMENT_PATH = "spec/support/sample_document.html"

FactoryGirl.define do
  # Valid document definition
  factory :document, class: SkoogleDocs::Document do
    initialize_with do
      sample_document = File.read(DOCUMENT_PATH) if File.exist?(DOCUMENT_PATH)
      new(sample_document || "")
    end
  end
end
