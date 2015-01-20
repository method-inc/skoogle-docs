FactoryGirl.define do
  factory :config, class: SkoogleDocs::Config do
    initialize_with do
      new(
        client_id: ENV["CLIENT_ID"] || "valid_client_id",
        client_secret: ENV["CLIENT_SECRET"] || "valid_client_secret",
        auth_code: ENV["AUTH_CODE"] || "valid_auth_code",
        application_name: ENV["APP_NAME"] || "Skoogle Docs",
        application_version: ENV["APP_VERSION"] || "0.0.1"
      )
    end

    factory :invalid_config do
      client_id "invalid_client_id"
      client_secret "invalid_client_secret"
      auth_code "invalid_auth_code"
    end

    factory :incomplete_config do
      client_id nil
    end

    factory :blank_config do
      client_id nil
      client_secret nil
      auth_code nil
    end
  end
end
