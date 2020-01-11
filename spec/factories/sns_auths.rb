FactoryBot.define do
  factory :sns_auth do
    provider {["google_oauth2", "facebook"].sample}
    uid {Faker::Internet.unique.password}
    user
  end
end