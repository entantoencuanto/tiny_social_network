require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    @user = FactoryGirl.create(:user)
    login_with(@user)
  end

  describe "GET #index" do
    it "assigns all users as @users" do
      get :index, {}
      expect(assigns(:users)).to eq([@user])
    end
  end

  describe "GET #followers" do
    it "assigns followers of a user as @users" do
      follower = FactoryGirl.create(:user)
      follower.follow(@user)
      get :index, { user_id: @user.to_param, collection: 'followers' }
      expect(assigns(:users)).to eq([follower])
    end
  end

  describe "GET #follows" do
    it "assigns users user follows as @users" do
      follower = FactoryGirl.create(:user)
      follower.follow(@user)
      get :index, { user_id: follower.to_param, collection: 'followeds' }
      expect(assigns(:users)).to eq([@user])
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      get :show, { id: @user.to_param }
      expect(assigns(:user)).to eq(@user)
    end
  end

  describe "PUT #follow" do
    it "include requested user in followeds collection of current_user" do
      followed = FactoryGirl.create(:user)
      expect(@user.followeds).to_not include(followed)
      put :follow, { id: followed.to_param }
      expect(@user.followeds).to include(followed)
    end
  end

  describe "PUT #unfollow" do
    it "remove requested user from followeds collection of current_user" do
      followed = FactoryGirl.create(:user)
      @user.follow(followed)
      expect(@user.followeds).to include(followed)
      put :unfollow, { id: followed.to_param }
      expect(@user.followeds).to_not include(followed)
    end
  end

end
