module SkoogleDocs
  # SkoogleDocs Browser object handles document requests to the Google Drive API
  #
  # @api public
  class Browser
    # Skoogle Docs only supports documents for now.
    DOC_MIME_TYPE = "application/vnd.google-apps.document"

    # Instantiates a new SkoogleDocs::Browser object
    #
    # @param config [SkoogleDocs::Configuration] the config object with API
    #   credentials
    #
    # @return [SkoogleDocs::Browser]
    def initialize(config)
      @session = SkoogleDocs::Session.new(config)
      @api = @session.api
    end

    # Makes a request to retrieve all documents accessible by the session
    #
    # @return [Array]
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
    def document_by_id(doc_id)
      result = @session.execute(
        api_method: @api.files.get,
        parameters: { fileId: doc_id }
      )

      file = validate_document(result)
      doc = download_document(file)

      SkoogleDocs::Document.new(doc)
    end

    # A wrapper for the constant file mime type restriction
    #
    # @note This is helpful if api later allows for other types of files
    #
    # @return [String]
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

    # Downloads the document's content from Google Drive
    #
    # @api private
    #
    # @param file [Google::APIClient::Schema::Drive::V2::File] an instace of
    #   the Google Drive file
    #
    # @raise [SkoogleDocs::Errors::DocumentNotFound] if the response is empty
    #
    # @return [String]
    def download_document(file)
      return "" unless file["exportLinks"] && file["exportLinks"]["text/html"]

      result = @session.execute(uri: file["exportLinks"]["text/html"])

      # TODO: Same as above, there might be other errors that need to be
      # captured
      unless result.status == 200
        raise SkoogleDocs::Errors::DocumentNotFound
      end

      result.body
    end
  end
end
