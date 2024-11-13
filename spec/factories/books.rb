FactoryBot.define do
  factory :book do
    title { "Sample Book" }
    author { "Author" }
    publication_year { 2020 }
    isbn { "1234567890" }
    average_rating { 1.5 }
  end
end
