FactoryGirl.define do
  # Valid browser definition
  factory :browser, class: SkoogleDocs::Browser do
    initialize_with do
      VCR.use_cassette("valid_session") do
        new(build(:config))
      end
    end
  end
end
