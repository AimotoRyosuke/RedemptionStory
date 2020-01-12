require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user){ create(:user) }
  let(:post){ create(:post) }
  let(:posts){ create_list(:post, 3) }
  before do
    log_in user
  end

  context "GET #index" do
    it "assigns @posts ordered by id DESC" do
      get :index
      expect(assigns(:posts)).to eq posts.sort{|a, b| b.id <=> a.id}
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  context "GET #show" do
    it "assigns @post" do
      get :show, params: {id: post}
      expect(assigns(:post)).to eq post
    end

    it "renders the :show template" do
      get :show, params: {id: post}
      expect(response).to render_template :show
    end
  end

  context "GET #search" do
    it "assigns @posts if params[:search] don't exist" do
      get :search
      expect(assigns(:posts)).to eq posts.sort{|a, b| b.id <=> a.id}
    end

    it "assigns @posts if params[:search] exist" do
      get :search, params: {search: {"keyword"=>"", "category_id"=>"", "date_start"=>"", "date_end"=>"", "month_start(2i)"=>"", "month_end(2i)"=>"", "gender"=>"男性", "age_start"=>"", "age_end"=>""}}
      results = []
      posts.each do |post|
        if post.user.gender == "男性"
          results << post
        end
      end
      expect(assigns(:posts)).to eq results.sort{|a, b| b.id <=> a.id}
    end

    it "renders the :search template" do
      get :search
      expect(response).to render_template :search
    end
  end

  context "GET #new" do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new 
    end

    it "redirect_to new_user_session_path if user is loged out" do
      log_out user
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "POST #create" do
    it "can create" do
      expect do
        post :create, params: {post: {title: post.title, text: post.text, date: post.date, user: post.user, category_id: post.category_id, tags: post.tags, images: post.images}}
      end.to change(Post, :count).by(1)
    end

    it "redirects to post_path after create" do
      # post :create
      # expect(response).to redirect_to post_path(post)
    end

    it "redirects to new_user_session_path if user is loged out" do
      # log_out user
      # expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "GET #edit" do
    it "assigns @post" do
      get :edit, params: {id: post}
      expect(assigns(:post)).to eq post
    end

    it "renders the :edit template" do
      get :edit, params: {id: post}
      expect(response).to render_template :edit
    end

    it "can't save if user is loged out" do
      log_out user
      get :edit, params: {id: post}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "PATCH #update" do
    it "can update" do
      patch :update, params: {id: post, post: {title: "更新されたものがたりのタイトル"}}
      post.reload
      expect(post.title).to eq("更新されたものがたりのタイトル")
    end

    it "redirect to post_path" do
      patch :update, params: {id: post, post: {title: "更新されたものがたりのタイトル"}}
      expect(response).to redirect_to(post_path(post))
    end

    it "redirect_to new_user_session_path if user is loged out" do
      log_out user
      patch :update, params: {id: post}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "DELETE #destroy" do
    it "can destroy" do
      expect do
        delete :destroy, params: {id: post}
      end.to change(Post, :count).by(-1)
    end

    it "redirects to root_path after destroy " do
      delete :destroy, params: {id: post}
      expect(response).to redirect_to(root_path)
    end

    it "redirect_to new_user_session_path if user is loged out" do
      log_out user
      delete :destroy, params: {id: post}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "GET #rakute_search" do
  end
end