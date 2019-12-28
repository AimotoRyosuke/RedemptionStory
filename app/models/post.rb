class Post < ApplicationRecord
  validates :title, :text, :date, :images, presence: true
  has_many :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :images

  def age
    (((self.date.year * 1000 + self.date.month * 100 + self.date.day) - (1993 * 1000 + 10 * 100 + 27))/1000.floor).to_s
  end

end