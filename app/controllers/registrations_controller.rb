class RegistrationsController < ApplicationController

  skip_before_action :authenticate!

  # GET /users/registrations/new
  # GET /sign_up
  def new
    @user = User.new
  end

  # POST /users/registrations
  # POST /do_user_sign_up
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: 'You have signed up successfully.'
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :user_name, :password, :password_confirmation)
  end
end
