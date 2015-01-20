module SkoogleDocs
  # SkoogleDocs Config object holds all configuration and app details
  #
  # @api public
  class Config
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

    # @!attribute [rw] application_name
    #   @returns [String] the name of the application
    #
    # @!attrubute [rw] application_version
    #   @returns [String] the version of the application
    attr_accessor :application_name, :application_version

    # Instantiates a new SkoogleDocs::Config object
    #
    # @param options [Hash] a configuration hash that can hold: `client_id`,
    #   `client_secret`, `auth_code`, `access_token`, `refresh_token`,
    #   `application_name`, `application_version`
    #
    # @return [SkoogleDocs::Config]
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

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
  end
end
