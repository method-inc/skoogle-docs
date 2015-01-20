module SkoogleDocs
  # SkoogleDocs Client object handles the main interaction with the gem.
  #
  # @api public
  class Client
    # Instantiates a new SkoogleDocs::Client object
    #
    # @param options [Hash] the Google API credentials, `client_id`,
    #   `client_secret`, `auth_code`, `application_name`, `application_version`
    #
    # @return [SkoogleDocs::Client]
    #
    # @example Using a Block
    #   client = SkoogleDocs::Client.new do |config|
    #     config.client_id = "my_client_id"
    #     config.client_secret = "my_client_secret"
    #     config.auth_code = "my_auth_code"
    #     config.application_name = "Skoogle Docs"
    #     config.application_version = "0.0.1"
    #   end
    #
    # @example Using a Hash
    #   client = SkoogleDocs::Client.new(
    #     client_id: "my_client_id",
    #     client_secret: "my_client_secret",
    #     auth_code: "my_auth_code",
    #     application_name: "Skoogle Docs",
    #     application_version: "0.0.1"
    #   )
    #
    # @example Blank Client
    #   client = SkoogleDocs::Client.new
    def initialize(options = {})
      @config = SkoogleDocs::Config.new

      options.each do |key, value|
        @config.instance_variable_set("@#{key}", value)
      end

      yield(@config) if block_given?
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

    # Wrapper for a SkoogleDocs::Browser instance
    #
    # @return [SkoogleDocs::Browser]
    def browser
      @browser ||= SkoogleDocs::Browser.new(@config)
    end
  end
end
