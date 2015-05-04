FactoryGirl.define do
  factory :user do
    sequence(:name) { |i| "kaori#{i}" }
    password "1234"
  end
end
