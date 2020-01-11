FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 6)
    nickname {Faker::Name.last_name}
    email {Faker::Internet.unique.free_email}
    password {password}
    password_confirmation {password}
    gender {["男性", "女性"].sample}
    birthday {Faker::Date.birthday(min_age: 5, max_age: 99)}
    image {File.open("#{Rails.root}/public/uploads/image/image/user_sample.png")}
  end
end
