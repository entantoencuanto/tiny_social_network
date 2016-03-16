class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: [:new, :create]

  # GET /users/sessions/new
  # GET /sign_in
  def new
    @user = User.new
  end

  # POST /users/sessions
  def create
    authenticate!
    redirect_to root_path
  end

  # DELETE /users/sessions
  def destroy
    logout!
    redirect_to root_path
  end
end
