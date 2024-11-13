FactoryBot.define do
  factory :book do
    title { "MyString" }
    author { "MyString" }
    publication_year { 1 }
    isbn { "MyString" }
    average_rating { 1.5 }
  end
end
