module SkoogleDocs
  module Bots
    # Bot in charge of adding the HTML5 document declaration
    #
    # @api public
    class DoctypeTag < SkoogleDocs::Bots::Bot
      # Constant to hold the HTML5 document type declaration
      DOCTYPE_DECLARATION = "<!DOCTYPE html>"

      # Replaces or add an HTML5 document type declaration to the top of the dom
      #
      # @param dom [Nokogiri::HTML::Document] the html document to transform
      #
      # @return [Nokogiri::HTML::Document]
      def self.transform(dom)
        doc = "#{DOCTYPE_DECLARATION} #{head(dom)} #{body(dom)}"
        Nokogiri::HTML(doc)
      end
    end
  end
end
