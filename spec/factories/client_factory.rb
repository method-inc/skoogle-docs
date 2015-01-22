FactoryGirl.define do
  factory :client, class: SkoogleDocs::Client do
    initialize_with do
      new(build(:full_configuration))
    end
  end

  factory :blank_client, class: SkoogleDocs::Client do
    initialize_with do
      new(build(:configuration))
    end
  end
end
