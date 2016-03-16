class WelcomeController < ApplicationController
  skip_before_action :authenticate!

  # GET /
  def index
  end
end
