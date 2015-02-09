module SkoogleDocs
  module Bots
    # Bot in charge of adding the UTF-8 encoding meta tag
    #
    # @api public
    class MetaTags < SkoogleDocs::Bots::Bot
      # Constant holding the meta tags to add
      METAS = ["UTF-8"]

      # Replaces or adds meta tags to the given dom
      #
      # @param dom [Nokogiri::HTML::Document] the html document to transform
      #
      # @return [Nokogiri::HTML::Document]
      def self.transform(dom)
        dom.meta_encoding = METAS.first
        Nokogiri::HTML(dom.to_s)
      end
    end
  end
end
