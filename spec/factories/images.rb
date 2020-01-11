FactoryBot.define do
  factory :image do
    image {File.open("#{Rails.root}/public/uploads/image/image/post_sample.jpeg")}
  end
end
