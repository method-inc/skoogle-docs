module SkoogleDocs
  module Bots
    # SkoogleDocs::Bots::Bot are the smallest components for transformations
    #
    # @api public
    class Bot
      # Defines an array that will hold all of the subclasses of `Bot`
      @all = []

      # Provides reference to the array with all of the `Bot` subclasses
      #
      # @return [Array]
      def self.all
        @all
      end

      # Callback to track of all the subclasses of `Bot` and store them
      def self.inherited(subclass)
        @all << subclass
      end

      # Fetches the html element of the document. It creates one if none exists
      #
      # @param dom [Nokogiri::HTML::Document] the html document
      #
      # @return [Nokogiri::XML::Element]
      def self.html(dom)
        doc_html = Nokogiri::HTML(dom.to_s).at_css("html")
        doc_html || Nokogiri::HTML("<html></html>").at_css("html")
      end

      # Fetches the head element of the document. It creates one if none exits
      #
      # @param dom [Nokogiri::HTML::Document] the html document
      #
      # @return [Nokogiri::XML::Element]
      def self.head(dom)
        doc_head = Nokogiri::HTML(dom.to_s).at_css("head")
        doc_head || Nokogiri::HTML("<head></head>").at_css("head")
      end

      # Fetches the body element of the document. It creates one if none exits
      #
      # @param dom [Nokogiri::HTML::Document] the html document
      #
      # @return [Nokogiri::XML::Element]
      def self.body(dom)
        doc_body = Nokogiri::HTML(dom.to_s).at_css("body")
        doc_body || Nokogiri::HTML("<body></body>").at_css("body")
      end
    end
  end
end
