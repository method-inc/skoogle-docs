module SkoogleDocs
  class Client
    # Constant declarations
    PERMISSION_SCOPE = "https://www.googleapis.com/auth/drive.readonly"
    REDIRECT_URI = "urn:ietf:wg:oauth:2.0:oob"

    # Configuration attributes
    attr_accessor :client_id, :client_secret, :access_token

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      yield(self) if block_given?
    end

    def credentials
      {
        client_id: client_id,
        client_secret: client_secret,
        token: access_token
      }
    end

    def credentials?
      credentials.values.all?
    end

    def permission_scope
      PERMISSION_SCOPE
    end

    def redirect_uri
      REDIRECT_URI
    end

    private

    def session
      @session ||= SkoogleDocs::Session.new(self)
    end

    def browser
      @browser ||= SkoogleDocs::Browser.new(session)
    end
  end
end
