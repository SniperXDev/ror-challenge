class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, presence: true
  validates_uniqueness_of :user_id, scope: :book_id

  validate :user_not_reviewed_book

  private

  def user_not_reviewed_book
    if self.class.exists?(user_id: user.id, book_id: book.id)
      errors.add(:base, "You have already reviewed this book")
    end
  end
end
