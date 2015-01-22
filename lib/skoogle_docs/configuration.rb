module SkoogleDocs
  # SkoogleDocs Config object holds all configuration and app details
  #
  # @api public
  class Configuration
    # Configuration detauls
    PERMISSION_SCOPE = "https://www.googleapis.com/auth/drive.readonly"
    REDIRECT_URI = "urn:ietf:wg:oauth:2.0:oob"
    APP_NAME = "Skoogle Docs"
    APP_VERSION = "0.0.1"

    # @!attribute [rw] client_id
    #   @returns [String] the Google API client ID
    #
    # @!attribute [rw] client_secret
    #   @returns [String] the Google API client secret
    #
    # @!attribute [rw] auth_code
    #   @returns [String] the single-use authorization code
    attr_accessor :client_id, :client_secret, :auth_code

    # @!attribute [rw] access_token
    #   @returns [String] the authorized access token
    #
    # @!attrubute [rw] refresh_token
    #   @returns [String] token used to obtain new access token
    attr_accessor :access_token, :refresh_token

    # @!attribute [rw] redirect_uri
    #   @returns [String] the redirect uri
    #
    # @!attrubute [rw] permission_scope
    #   @returns [String] the permission scope
    attr_accessor :redirect_uri, :permission_scope

    # @!attribute [rw] application_name
    #   @returns [String] the name of the application
    #
    # @!attrubute [rw] application_version
    #   @returns [String] the version of the application
    attr_accessor :application_name, :application_version

    # Instantiates a new SkoogleDocs::Configuration object
    #
    # @return [SkoogleDocs::Configuration]
    def initialize
      configure_defaults
      yield(self) if block_given?
    end

    # Wraps the application information into a Hash containing
    #   `application_name` and `application_version`
    #
    # @return [Hash]
    def application_info
      {
        application_name: application_name,
        application_version: application_version
      }
    end

    # Wraps the API credentials into a Hash containing `client_id`,
    #   `client_secret`, and `auth_code`. Required for the application to run
    #
    # @return [Hash]
    def credentials
      {
        client_id: client_id,
        client_secret: client_secret,
        auth_code: auth_code
      }
    end

    # Validates that all API credentails are present
    #
    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end

    private

    def configure_defaults
      @redirect_uri = REDIRECT_URI
      @permission_scope = PERMISSION_SCOPE
      @application_name = APP_NAME
      @application_version = APP_VERSION
    end
  end
end
