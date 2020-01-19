class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :title, :text, :date, :tags, :category_id, :images, presence: true
  has_many :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  belongs_to :user
  belongs_to_active_hash :category
  accepts_nested_attributes_for :tags, allow_destroy: true
  accepts_nested_attributes_for :images, allow_destroy: true
  def age
    (((self.date.year * 1000 + self.date.month * 100 + self.date.day) - (self.user.birthday.year * 1000 + self.user.birthday.month * 100 + self.user.birthday.day))/1000.floor).to_s
  end

  scope :title, ->(keyword) { where("(title LIKE(?))", "%#{keyword}%") if keyword.present? }
  scope :text, ->(keyword){ where("(text LIKE(?))", "%#{keyword}%") if keyword.present? }
  scope :with_tag, -> { joins(:tags) }
  scope :tag, ->(keyword){(where("(name LIKE(?))", "%#{keyword}%")) if keyword.present? }
  scope :keyword, ->(keyword){ title(keyword).or(text(keyword)).or(tag(keyword))}
  scope :category, ->(category_id){ where(category_id: category_id) if category_id.present?}
  scope :first_date, ->(date_start){ where("updated_at >= ?", Date.strptime(date_start, "%Y-%m-%d")) if date_start.present? }
  scope :last_date, ->(date_end){ where("updated_at <= ?", Date.strptime(date_end, "%Y-%m-%d")) if date_end.present? }
  scope :first_month, ->(month_start){ where('extract(month from date) >= ?', month_start.to_i) if month_start.present?}
  scope :last_month, ->(month_end){ where('extract(month from date) <= ?', month_end.to_i) if month_end.present?}
  scope :gender, ->(gender){ where(user_id: User.where(gender: gender)) if gender.present?}
  scope :first_age, ->(age_start) do
    if age_start.present?
      post_ids = []
      Post.all.each do |post|
        if post.age.to_i >= age_start.to_i
          post_ids << post.id
        end
      end
      puts post_ids
      return Post.where(id: post_ids)
    else
      Post.all
    end
  end
  scope :last_age, ->(age_end) do
    if age_end.present?
      post_ids = []
      Post.all.each do |post|
        if post.age.to_i <= age_end.to_i
          post_ids << post.id
        end
      end
      puts post_ids
      return Post.where(id: post_ids)
    else
      Post.all
    end
  end

  scope :search, -> (keyword, category_id, date_start, date_end, month_start, month_end, gender, age_start, age_end){
    keyword(keyword).category(category_id).first_date(date_start).last_date(date_end).first_month(month_start).last_month(month_end).gender(gender).first_age(age_start).last_age(age_end)}

end