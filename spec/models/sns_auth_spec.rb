require 'rails_helper'

RSpec.describe SnsAuth, type: :model do
  context "can save" do
    it "is valid with provider, uid and user_id" do
      sns_auth = build(:sns_auth)
      expect(sns_auth).to be_valid
    end
  end

  context "can't save" do
    it "is invalid without provider" do
      sns_auth = build(:sns_auth, provider: nil)
      sns_auth.valid?
      expect(sns_auth.errors[:provider]).to include("を入力してください")
    end

    it "is invalid without uid" do
      sns_auth = build(:sns_auth, uid: nil)
      sns_auth.valid?
      expect(sns_auth.errors[:uid]).to include("を入力してください")
    end

    it "is invalid without user_id" do
      sns_auth = build(:sns_auth, user: nil)
      sns_auth.valid?
      expect(sns_auth.errors[:user]).to include("を入力してください")
    end
  end
end