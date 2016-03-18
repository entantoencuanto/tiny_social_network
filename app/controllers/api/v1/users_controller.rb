module Api
  module V1
    class UsersController < ApiController
      before_action :set_user, only: [:show]
      before_action :set_collection_proxy, only: [:index]
      def index
        @users = @collection_proxy.all
        render json: @users
      end

      def show
        render json: @user
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
  end
end
