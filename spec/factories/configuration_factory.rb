FactoryGirl.define do
  factory :configuration, class: SkoogleDocs::Configuration do

    factory :bad_configuration do
      client_id "invalid_client_id"
      client_secret "invalid_client_secret"
    end

    factory :full_configuration do
      client_id ENV["CLIENT_ID"] || "client_id"
      client_secret ENV["CLIENT_SECRET"] || "client_secret"
      auth_code ENV["AUTH_CODE"] || "auth_code"
    end
  end
end
