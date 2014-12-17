FactoryGirl.define do
  # Valid browser definition
  factory :browser, class: SkoogleDocs::Browser do
    initialize_with do
      new(build(:session))
    end
  end
end
