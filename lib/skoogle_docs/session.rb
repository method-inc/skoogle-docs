module SkoogleDocs
  class Session
    def initialize(client)
      unless client.credentials?
        raise SkoogleDocs::Errors::BadAuthenticationData
      end

      @client = client
      configure_google_client
    end

    def api
      @drive
    end

    def execute(params)
      @google_client.execute(params)
    end

    private

    def configure_google_client
      @google_client = Google::APIClient.new
      @google_client.retries = 2
      @drive = @google_client.discovered_api("drive", "v2")
      authorize
    end

    def authorize
      auth = @google_client.authorization
      auth.client_id = @client.client_id
      auth.client_secret = @client.client_secret
      auth.redirect_uri = @client.redirect_uri
      auth.scope = @client.permission_scope
      auth.code = @client.access_token
      fetch_access_token(auth)
    end

    def fetch_access_token(auth)
      auth.fetch_access_token!
    rescue Signet::AuthorizationError
      raise SkoogleDocs::Errors::AuthorizationError
    end
  end
end
