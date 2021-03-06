class UsersController < ApplicationController
  skip_before_action :authenticate!, only: [:index, :show]
  before_action :set_user, only: [:show, :follow, :unfollow]
  before_action :set_collection_proxy, only: [:index]

  # GET /users
  def index
    @users = @collection_proxy.all
  end

  # GET /users/1
  def show
    @is_followed = (signed_in? and current_user.followeds.include?(@user))
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

    def set_collection_proxy
      if params[:user_id].present?
        @parent_user = User.find(params[:user_id])
        @collection_proxy = @parent_user.get_collection(collection_param)
      else
        @collection_proxy = User
      end
    end

    def collection_param
        params.require(:collection)
    end
end
