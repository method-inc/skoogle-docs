module SkoogleDocs
  class Browser
    # Skoogle Docs only supports documents for now.
    DOC_MIME_TYPE = "application/vnd.google-apps.document"

    def initialize(session)
      @session = session
      @api = session.api
    end

    def documents
      @session.execute(
        api_method: @api.files.list,
        parameters: { q: "mimeType = '#{DOC_MIME_TYPE}'" }
      ).data.items
    end

    def document_by_id(doc_id)
      doc = @session.execute(
        api_method: @api.files.get,
        parameters: { fileId: doc_id }
      )

      validate_document(doc)
    end

    def mime_type
      DOC_MIME_TYPE
    end

    private

    def validate_document(doc)
      # TODO: It is possible to have other errors so don't bucket
      # every error as "not found" (404)
      it_was_found = doc.status == 200
      raise SkoogleDocs::Errors::DocumentNotFound unless it_was_found

      it_is_document = doc.data.mimeType == DOC_MIME_TYPE
      raise SkoogleDocs::Errors::InvalidDocument unless it_is_document

      doc.data
    end
  end
end
