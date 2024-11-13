# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(email: 'admin@example.com', password: 'password')

Book.create!([
  { title: 'Book 1', author: 'Author 1', publication_year: 2000, isbn: '1234567890' },
  { title: 'Book 2', author: 'Author 2', publication_year: 2010, isbn: '1234567890123' }
])
