require 'rails_helper'

RSpec.describe Like, type: :model do
  context "can save" do
    it 'is valid with text, user_id and post_id' do
      like = build(:like)
      expect(like).to be_valid
    end
  end

  context "can't save" do
    it 'is invalid without user_id' do
      like = build(:like, user: nil)
      like.valid?
      expect(like.errors[:user]).to include("を入力してください")
    end
    
    it 'is invalid without post_id' do
      like = build(:like, post: nil)
      like.valid?
      expect(like.errors[:post]).to include("を入力してください")
    end
  end
end
