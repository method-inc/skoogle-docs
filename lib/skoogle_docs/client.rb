module SkoogleDocs
  # SkoogleDocs Client object handles the main interaction with the gem.
  #
  # @api public
  class Client
    PERMISSION_SCOPE = "https://www.googleapis.com/auth/drive.readonly"
    REDIRECT_URI = "urn:ietf:wg:oauth:2.0:oob"

    # @!attribute [rw] client_id
    #   @return [String] the Google API client ID
    #
    # @!attribute [rw] client_secret
    #   @return [String] the Google API client secret
    #
    # @!attribute [rw] access_token
    #   @return [String] the Google API access token
    attr_accessor :client_id, :client_secret, :access_token

    # @!attribute [rw] application_name
    #   @return [String] a name for your application (optional)
    #
    # @!attribute [rw] application_version
    #   @return [String] the version of your application (optional)
    attr_accessor :application_name, :application_version

    # Instantiates a new SkoogleDocs::Client object
    #
    # @param options [Hash] the Google API credentials, `client_id`,
    #   `client_secret`, and `access_token`
    #
    # @return [SkoogleDocs::Client]
    #
    # @example Using a Block
    #   client = SkoogleDocs::Client.new do |config|
    #     config.client_id = "my_client_id"
    #     config.client_secret = "my_client_secret"
    #     config.access_token = "my_access_token"
    #     config.application_name = "Skoogle Docs"
    #     config.application_version = "0.0.1"
    #   end
    #
    # @example Using a Hash
    #   client = SkoogleDocs::Client.new(
    #     client_id: "my_client_id",
    #     client_secret: "my_client_secret",
    #     access_token: "my_access_token",
    #     application_name: "Skoogle Docs",
    #     application_version: "0.0.1"
    #   )
    #
    # @example Blank Client
    #   client = SkoogleDocs::Client.new
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      yield(self) if block_given?
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

    # Wraps the Google API credentials into a Hash
    #
    # @return [Hash]
    def credentials
      {
        client_id: client_id,
        client_secret: client_secret,
        token: access_token
      }
    end

    # Wraps the application details into a Hash
    #
    # @return [Hash]
    def details
      {
        application_name: application_name,
        application_version: application_version
      }
    end

    # Validates all Google API credentials are present
    #
    # @return [Boolean]
    #
    # @example Credentials are Present
    #   client = SkoogleDocs::Client.new do |config|
    #     config.client_id = "my_client_id",
    #     config.client_secret = "my_client_secret",
    #     config.access_token = "my_access_token"
    #   end
    #
    #   client.credentials? # => true
    #
    # @example Credentials are Missing
    #   client = SkoogleDocs::Client.new do |config|
    #     config.client_id = "my_client_id"
    #   end
    #
    #   client.credentials? # => false
    def credentials?
      credentials.values.all?
    end

    # Permission scope used to access the Google API
    #
    # @return [String]
    def permission_scope
      PERMISSION_SCOPE
    end

    # Redirect URI used by the Google API
    #
    # @return [String]
    def redirect_uri
      REDIRECT_URI
    end

    # Wrapper for a SkoogleDocs::Browser instance
    #
    # @return [SkoogleDocs::Browser]
    def browser
      @browser ||= SkoogleDocs::Browser.new(session)
    end

    private

    # Wrapper for a SkoogleDocs::Session instance
    #
    # @api private
    #
    # @return [SkoogleDocs::Session]
    def session
      @session ||= SkoogleDocs::Session.new(self)
    end
  end
end
