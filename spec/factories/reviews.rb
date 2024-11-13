FactoryBot.define do
  factory :review do
    rating { 1 }
    content { "MyText" }
    book { nil }
    user { nil }
  end
end
