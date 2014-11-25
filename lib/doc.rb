require 'google_drive'

module SkoogleDoc
  class Doc
    def initialize(google_docs_key)
      @google_docs_key = google_docs_key
      @session = self.class.session
    end

    # Get the latest version from Google
    #
    # @return [GoogleDrive::File]
    def latest_from_google
      @latest_from_google ||= @session.file_by_key(@google_docs_key)
    end

    def files
      @files ||= @session.files
    end

    def transform(string)
      body = string ? Nokogiri::HTML(string).css('body').to_s
          : @latest_from_google.body
      dom = Nokogiri::HTML(body)
      SkoogleDoc::Transformers.link(dom, './styleguide.css')
      SkoogleDoc::Transformers.meta(dom, {content: 'UTF-8'})
      SkoogleDoc::Transformers.wrap_content(dom)
      SkoogleDoc::Transformers.cover_page(dom)
      SkoogleDoc::Transformers.styled_lists(dom)

      # apply transformations
      if ENV['SKOOGLE_TEST']
        path = File.join(__dir__, "..", "tmp", "index.html")
        File.write(path, dom.to_html)
        # system %{open #{path}}
      end

      dom.to_html
    end

    private

    # Fetch the document directly from Google
    #
    # @param key [String] google docs key
    # @return [GoogleDrive::File] Parsed body and updated_at properties for the doc
    def self.fetch_from_google(key)
      session.file_by_key(key)
    end

    # Fetch a google session
    #
    # @return [Session]
    def self.session
      return @session if @session 

      if (ENV['GOOGLE_DRIVE_CLIENT_ID']) 
        self.login_with_oauth(ENV['GOOGLE_DRIVE_CLIENT_ID'], ENV['GOOGLE_DRIVE_CLIENT_SECRET'])
      else
        GoogleDrive.login(ENV['GOOGLE_DRIVE_USER'], ENV['GOOGLE_DRIVE_PASSWORD'])
      end
    end

    # Create an oauth session
    #
    # @return [Session]
    def self.login_with_oauth(client_id, client_secret)
      client = Google::APIClient.new
      auth = client.authorization
      auth.client_id = client_id
      auth.client_secret = client_secret
      auth.scope =
        "https://www.googleapis.com/auth/drive " +
        "https://docs.google.com/feeds/ " +
        "https://docs.googleusercontent.com/ "
      auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
      print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
      print("2. Enter the authorization code shown in the page: ")
      auth.code = $stdin.gets.chomp
      auth.fetch_access_token!
      access_token = auth.access_token

      # Creates a session.
      GoogleDrive.login_with_oauth(access_token)
    end

  end
end
