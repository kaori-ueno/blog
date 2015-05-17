FactoryGirl.define do
  factory :blog do
    name "Blog"
    association :user
  end
end
