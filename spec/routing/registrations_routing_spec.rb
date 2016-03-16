require "rails_helper"

RSpec.describe RegistrationsController, type: :routing do
  describe "routing" do

    it "get request to #sign_up" do
      expect(:get => "/sign_up").to route_to("registrations#new")
    end

    it "post request to #sign_up" do
      expect(:post => "/sign_up").to route_to("registrations#create")
    end
  end
end
