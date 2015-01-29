module SkoogleDocs
  module Bots
    # Bot in charge of applying custom directives to lists
    #
    # @api public
    class StyledLists < SkoogleDocs::Bots::Bot
      # Looks for lists with directives and applies css class to them
      #
      # @param dom [Nokogiri::HTML::Document] the html document to transform
      #
      # @return [Nokogiri::HTML::Document]
      def self.transform(dom)
        lists = extract_lists(dom)
        build_lists(lists)

        Nokogiri::HTML(dom.to_s)
      end

      # Searches for the lasts elements of every list in the dom
      #
      # @param dom [Nokogiri::HTML::Document] the html document to search in
      #
      # @return [Array]
      def self.extract_lists(dom)
        dom.search("li:last")
      end

      # Adds the CSS classes to the directive lists and removes the last element
      #
      # @param lists [Array<Nokogiri::XML::Element>] an array of li elements
      #
      # @return [Array]
      def self.build_lists(lists)
        lists.each do |li|
          if "#" == li.content[0]
            css_class = li.content.gsub("#", "").downcase
            li.parent[:class] = "#{li.parent[:class]} #{css_class}"
            li.remove
          end
        end
      end
    end
  end
end
