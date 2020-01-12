require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "can save" do
    it 'is valid with text, user_id and post_id' do
      comment = build(:comment)
      expect(comment).to be_valid
    end
  end

  context "can't save" do
    it 'is invalid without text' do
      comment = build(:comment, text: nil)
      comment.valid?
      expect(comment.errors[:text]).to include("を入力してください")
    end

    it 'is invalid without user_id' do
      comment = build(:comment, user: nil)
      comment.valid?
      expect(comment.errors[:user]).to include("を入力してください")
    end

    it 'is invalid without post_id' do
      comment = build(:comment, post: nil)
      comment.valid?
      expect(comment.errors[:post]).to include("を入力してください")
    end
  end
end
