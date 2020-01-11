FactoryBot.define do
  factory :post do
    title {"ものがたりのタイトル"}
    text {"こんなプレゼントをもらった"}
    date {Faker::Date.between(from: 2.days.ago, to: Date.today)}
    category {Category.all.all_records.sample}
    user
    tags {[build(:tag)]}
    images {[build(:image)]}
  end
end
