FactoryGirl.define do
  factory :article do
    title "Title"
    body "Body"
    association :blog
  end
end
