module SkoogleDocs
  # SkoogleDocs Client object handles the main interaction with the gem.
  #
  # @api public
  class Client
    # @!attribute [rw] config
    #   @returns [SkoogleDocs::Configuration] a configuration object
    attr_accessor :config

    # Instantiates a new SkoogleDocs::Client object
    # @param config [SkoogleDocs::Configuration] the config object with
    #   Google API credentials
    #
    # @raise [SkoogleDocs::Error::AuthorizationError] if client credentials are
    #   invalid
    #
    # @return [SkoogleDocs::Client]
    def initialize(config)
      unless config.credentials?
        raise SkoogleDocs::Errors::BadAuthenticationData
      end

      @config = config
    end

    # Returns a list of all documents accessible to this client
    #
    # @return [Array]
    def documents
      browser.documents
    end

    # Returns a document based on the provided ID
    #
    # @param doc_id [String] the id of the document to look for
    #
    # @raise [SkoogleDocs::Errors::DocumentNotFound] if no document was found
    #
    # @raise [SkoogleDocs::Errors::InvalidDocument] if the document is not a
    #   Google Document
    #
    # @return [SkoogleDocs::Document]
    def document_by_id(doc_id)
      browser.document_by_id(doc_id)
    end

    private

    # Wrapper for a SkoogleDocs::Browser instance
    #
    # @return [SkoogleDocs::Browser]
    def browser
      @browser ||= SkoogleDocs::Browser.new(@config)
    end
  end
end
