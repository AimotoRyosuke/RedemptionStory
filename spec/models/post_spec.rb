require 'rails_helper'

RSpec.describe Post, type: :model do

  context "can save" do
    it "is valid with title, text, date, user_id, category_id, tags and images" do
      post = build(:post)
      expect(post).to be_valid
    end
  end

  context "can not save" do
    it "is invalid without title" do
      post = build(:post, title: nil)
      post.valid?
      expect(post.errors[:title]).to include("を入力してください")
    end
    
    it "is invalid without text" do
      post = build(:post, text: nil)
      post.valid?
      expect(post.errors[:text]).to include("を入力してください")
    end

    it "is invalid without date" do
      post = build(:post, date: nil)
      post.valid?
      expect(post.errors[:date]).to include("を入力してください")
    end

    it "is invalid without user_id" do
      post = build(:post, user_id: nil)
      post.valid?
      expect(post.errors[:user]).to include("を入力してください")
    end

    it "is invalid without category_id" do
      post = build(:post, category_id: nil)
      post.valid?
      expect(post.errors[:category_id]).to include("を入力してください")
    end

    it "is invalid without tag" do
      post = build(:post, tags: [])
      post.valid?
      expect(post.errors[:tags]).to include("を入力してください")
    end

    it "is invalid without image" do
      post = build(:post, images: [])
      post.valid?
      expect(post.errors[:images]).to include("を入力してください")
    end
  end
end