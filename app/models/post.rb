class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :title, :text, :date, :tags, :category_id, :images, presence: true
  has_many :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags
  belongs_to :user
  belongs_to_active_hash :category
  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :images
  def age
    (((self.date.year * 1000 + self.date.month * 100 + self.date.day) - (1993 * 1000 + 10 * 100 + 27))/1000.floor).to_s
  end
end