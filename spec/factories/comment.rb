FactoryGirl.define do
  factory :comment do
    body "Body"
    association :owner, factory: :user
    association :article
  end
end
