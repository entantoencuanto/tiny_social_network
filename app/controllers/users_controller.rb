class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow, :unfollow]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @is_followed = current_user.followeds.include?(@user)
  end

  # PUT users/1/follow
  def follow
    current_user.follow(@user)
    redirect_to @user, notice: 'Follow added!'
  end

  # PUT users/1/unfollow
  def unfollow
    current_user.unfollow(@user)
    redirect_to @user, notice: 'Follow deleted!'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
