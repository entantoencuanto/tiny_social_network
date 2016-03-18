require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/users").to route_to("users#index")
    end

    it "routes to #followers" do
      expect(:get => "/users/1/followers").to route_to("users#index", user_id: '1', collection: 'followers')
    end

    it "routes to #followeds" do
      expect(:get => "/users/1/followeds").to route_to("users#index", user_id: '1', collection: 'followeds')
    end

    it "routes to #show" do
      expect(:get => "/users/1").to route_to("users#show", :id => "1")
    end

    it "routes to #follow" do
      expect(:put => "/users/1/follow").to route_to("users#follow", :id => "1")
    end

    it "routes to #unfollow" do
      expect(:put => "/users/1/unfollow").to route_to("users#unfollow", :id => "1")
    end

  end
end
