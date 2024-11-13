class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :publication_year
      t.string :isbn
      t.float :average_rating

      t.timestamps
    end
  end
end
