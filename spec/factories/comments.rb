FactoryBot.define do
  factory :comment do
    text {"sample"}
    user {create(:user)}
    post {create(:post)}
  end
end
