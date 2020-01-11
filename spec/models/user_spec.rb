require 'rails_helper'

RSpec.describe User, type: :model do

  context "can save" do
    it "is valid with nickname, email, password, gender, birthday and image" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is valid without image" do
      user = build(:user, image: nil)
      expect(user).to be_valid
    end

    it "is valid with a nickname of 6 characters or more" do
      password = "111111"
      user = build(:user, password: password, password_confirmation: password)
      user.valid?
      expect(user).to be_valid
    end
  end

  context "can not save" do
    it "is invalid without nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "is invalid without email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "is invalid without password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "is invalid without gender" do
      user = build(:user, gender: nil)
      user.valid?
      expect(user.errors[:gender]).to include("を入力してください")
    end

    it "is invalid without birthday" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end

    it "is invalid if passowrd and password_confirmation don't match" do
      user = build(:user, password_confirmation: Faker::Internet.unique.password(min_length: 6))
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
    

    it "is invalid with a nickname of 5 characters or less" do
      password = "11111"
      user = build(:user, password: password, password_confirmation: password)
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end
  end
end