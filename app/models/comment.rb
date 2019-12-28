class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :text, :post_id, :user_id, presence: true
  validates :text, length: {maximum: 300}
end
