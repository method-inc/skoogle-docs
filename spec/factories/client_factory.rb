FactoryGirl.define do
  factory :client, class: SkoogleDocs::Client do
    # Valid client definition
    initialize_with do
      new(
        client_id:     ENV["CLIENT_ID"]     || "valid_client_id",
        client_secret: ENV["CLIENT_SECRET"] || "valid_client_secret",
        access_token:  ENV["ACCESS_TOKEN"]  || "valid_access_token"
      )
    end

    # Client has all credentials defined but are invalid/incorrect
    factory :invalid_client do
      client_id "invalid_client_id"
      client_secret "invalid_client_secret"
      access_token "invalid_access_token"
    end

    # Client has some credentials defined but not all
    factory :incomplete_client do
      client_id nil
    end

    # Client has no credentials defined
    factory :blank_client do
      client_id nil
      client_secret nil
      access_token nil
    end
  end
end
