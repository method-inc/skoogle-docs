module SkoogleDocs
  # SkoogleDocs Browser object handles document requests to the Google Drive API
  #
  # @api public
  class Browser
    # Skoogle Docs only supports documents for now.
    DOC_MIME_TYPE = "application/vnd.google-apps.document"

    # Instantiates a new SkoogleDocs::Browser object
    #
    # @param session [SkoogleDocs::Session] the authenticated session object
    #   to execute requests against the Google API
    #
    # @return [SkoogleDocs::Browser]
    #
    # @example Using Existing Session
    #   browser = SkoogleDocs::Browser.new(session)
    def initialize(session)
      @session = session
      @api = session.api
    end

    # Makes a request to retrieve all documents accessible by the session
    #
    # @return [Array]
    #
    # @example Fetching Documents
    #   browser = SkoogleDocs::Browser.new(session)
    #   docs = browser.documents
    def documents
      @session.execute(
        api_method: @api.files.list,
        parameters: { q: "mimeType = '#{DOC_MIME_TYPE}'" }
      ).data.items
    end

    # Makes a request to retrieve a document based on the ID
    #
    # @param doc_id [String] the id of the document to look for
    #
    # @raise [SkoogleDocs::Errors::DocumentNotFound] if the response is empty
    #   for the given document ID
    #
    # @raise [SkoogleDocs::Errors::InvalidDocument] if the document received is
    #   not a Google Document
    #
    # @return [SkoogleDocs::Document]
    #
    # @example Fetching Single Document
    #   browser = SkoogleDocs::Browser.new(session)
    #   doc = browser.document_by_id("DOC10ID")
    def document_by_id(doc_id)
      doc = @session.execute(
        api_method: @api.files.get,
        parameters: { fileId: doc_id }
      )

      validate_document(doc)
    end

    # A wrapper for the constant file mime type restriction
    #
    # @note This is helpful if api later allows for other types of files
    #
    # @return [String]
    #
    # @example Accessing MIME Type
    #   browser = SkoogleDocs::Browser.new(session)
    #   browser.mime_type
    def mime_type
      DOC_MIME_TYPE
    end

    private

    # Validates the document exists and that it is a Google Doc type
    #
    # @api private
    #
    # @param doc [Google::APIClient::Result] document to validate
    #
    # @raise [SkoogleDocs::Errors::DocumentNotFound] if the response is empty
    #   for the given document ID
    #
    # @raise [SkoogleDocs::Errors::InvalidDocument] if the document received is
    #   not a Google Document
    #
    # @return [SkoogleDocs::Document]
    def validate_document(doc)
      # TODO: It is possible to have other errors so don't bucket
      # every error as "not found" (404)
      unless doc.status == 200
        raise SkoogleDocs::Errors::DocumentNotFound
      end

      unless doc.data.mimeType == DOC_MIME_TYPE
        raise SkoogleDocs::Errors::InvalidDocument
      end

      doc.data
    end
  end
end
