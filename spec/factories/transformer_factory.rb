FactoryGirl.define do
  factory :transformer, class: SkoogleDocs::Transformer do
    initialize_with do
      new(build(:document).source)
    end
  end
end
