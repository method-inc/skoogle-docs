FULL_DOC_PATH = "spec/support/sample_document.html"
NO_HEAD_DOC_PATH = "spec/support/no_head_doc.html"
NO_BODY_DOC_PATH = "spec/support/no_body_doc.html"
MINI_DOC_PATH = "spec/support/mini_doc.html"
LISTS_DOC_PATH = "spec/support/lists_dom.html"

FactoryGirl.define do
  factory :dom, class: Nokogiri::HTML::Document do
    initialize_with do
      build_dom(FULL_DOC_PATH)
    end

    factory :no_head_dom do
      initialize_with do
        build_dom(NO_HEAD_DOC_PATH)
      end
    end

    factory :no_body_dom do
      initialize_with do
        build_dom(NO_BODY_DOC_PATH)
      end
    end

    factory :mini_dom do
      initialize_with do
        build_dom(MINI_DOC_PATH)
      end
    end

    factory :lists_dom do
      initialize_with do
        build_dom(LISTS_DOC_PATH)
      end
    end

    factory :empty_dom do
      initialize_with do
        new
      end
    end
  end
end

def load_file(path)
  return "" unless File.exist?(path)
  File.read(path)
end

def build_dom(path)
  Nokogiri::HTML::Document.parse(load_file(path))
end
