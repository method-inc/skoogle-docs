module SkoogleDocs
  class Document
    # TODO: Refactor this
    def transform(string)
      # if string
      #   body = Nokogiri::HTML(string).css("body").to_s
      # else
      #   @latest_from_google.body
      # end

      # dom = Nokogiri::HTML("<!DOCTYPE html>" + body)
      # SkoogleDoc::Transformers.link(dom, "./styleguide.css")
      # SkoogleDoc::Transformers.meta(dom, content: "UTF-8")
      # SkoogleDoc::Transformers.wrap_content(dom)
      # SkoogleDoc::Transformers.cover_page(dom)
      # SkoogleDoc::Transformers.styled_lists(dom)
      # SkoogleDoc::Transformers.table_of_contents(dom)

      # apply transformations
      # if ENV["SKOOGLE_TEST"]
      #   path = File.join(__dir__, "..", "tmp", "index.html")
      #   File.write(path, dom.to_html)
      #   # system %{open #{path}}
      # end

      # dom.to_html
    end
  end
end
