require "rails_helper"

RSpec.describe Api::V1::MessagesController, type: :routing do
  describe "routing" do
    it "routes to user nested #messages" do
      expect(:get => "/api/users/1/messages").to route_to("api/v1/messages#index", user_id: '1')
    end

    it "routes to #show" do
      expect(:get => "/api/messages/1").to route_to("api/v1/messages#show", :id => "1")
    end
  end
end


