module SkoogleDocs
  # SkoogleDocs Document object holds file content and transformation
  #
  # @api public
  class Document
    # @!attribute [rw] source
    #   @returns [String] the original document text
    attr_accessor :source

    # Instantiates a new SkoogleDocs::Document object
    #
    # @param source [String] the string representation of the dom
    #
    # @return [SkoogleDocs::Document]
    def initialize(source)
      @source = source
    end

    # Runs through the source text and applies transformations
    #
    # @returns [Nokogiri::HTML]
    def transform
      transformer.rollout
    end

    private

    # Wrapper for a SkoogleDocs::Transformer instance
    #
    # @return [SkoogleDocs::Transformer]
    def transformer
      SkoogleDocs::Transformer.new(@source)
    end
  end
end
