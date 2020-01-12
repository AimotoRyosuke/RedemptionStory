require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  before do
    log_in user
  end

  context "GET signup_menu" do
    it "renders the :signup_menu template" do
      log_out user
      get :signup_menu
      expect(response).to render_template :signup_menu
    end

    it "under login" do
      get :signup_menu
      expect(response).to redirect_to(root_path)
    end
  end

  context "GET #show" do
    it "assigns @user" do
      get :show, params: {id: user}
      expect(assigns(:user)).to eq user
    end

    it "renders the :show template" do
      get :show, params: {id: user}
      expect(response).to render_template :show
    end
  end

  context "PUT #follow" do
    it "renders the :follow template" do
      expect(response).to render_template :follow
    end
  end

  context "PUT #unfollow" do
    it "renders the :unfollow template" do
      expect(response).to render_template :unfollow
    end
  end

  context "GET #followlist" do
    it "assigns @user" do
      get :followlist, params: {id: user}
      expect(assigns(:user)).to eq user
    end
  end

  context "GET #followerlist" do
    it "assigns @user" do
      get :followerlist, params: {id: user}
      expect(assigns(:user)).to eq user
    end
  end

end
