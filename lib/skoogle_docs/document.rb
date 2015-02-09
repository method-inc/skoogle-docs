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
    # @param klass [Class] the class to instantiate (must respond to `#rollout`)
    #
    # @return [Object]
    def transformer(klass = SkoogleDocs::Transformer)
      klass.new(@source)
    end
  end
end
