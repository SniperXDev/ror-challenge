FactoryBot.define do
  factory :review do
    rating { 4 }
    content { "Great book!" }
    association :book
    association :user
  end
end
