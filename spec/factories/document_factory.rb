DOCUMENT_PATH = "spec/support/sample_document.html"
DOCTYPE_DOC_PATH = "spec/support/doctype_tag_doc.html"
META_TAGS_DOC_PATH = "spec/support/meta_tags_doc.html"

FactoryGirl.define do
  # Valid document definition
  factory :document, class: SkoogleDocs::Document do
    initialize_with do
      sample_document = File.read(DOCUMENT_PATH) if File.exist?(DOCUMENT_PATH)
      new(sample_document || "")
    end

    trait :doctype_tag do
      doc = File.read(DOCTYPE_DOC_PATH) if File.exist?(DOCTYPE_DOC_PATH)
      source doc || ""
    end

    trait :meta_tags do
      doc = File.read(META_TAGS_DOC_PATH) if File.exist?(META_TAGS_DOC_PATH)
      source doc || ""
    end
  end
end
