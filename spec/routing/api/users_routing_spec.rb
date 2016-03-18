require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/users").to route_to("api/v1/users#index")
    end

    it "routes to #followers" do
      expect(:get => "/api/users/1/followers").to route_to("api/v1/users#index", user_id: '1', collection: 'followers')
    end

    it "routes to #followeds" do
      expect(:get => "/api/users/1/followeds").to route_to("api/v1/users#index", user_id: '1', collection: 'followeds')
    end
  end
end


