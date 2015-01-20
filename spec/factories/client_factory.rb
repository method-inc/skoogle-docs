FactoryGirl.define do
  factory :client, class: SkoogleDocs::Client do
    # Valid client definition
    initialize_with do
      new(
        client_id: ENV["CLIENT_ID"] || "valid_client_id",
        client_secret: ENV["CLIENT_SECRET"] || "valid_client_secret",
        auth_code: ENV["AUTH_CODE"] || "valid_auth_code",
        application_name: ENV["APP_NAME"] || "Skoogle Docs",
        application_version: ENV["APP_VERSION"] || "0.0.1"
      )
    end
  end
end
