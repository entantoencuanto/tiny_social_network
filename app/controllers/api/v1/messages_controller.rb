module Api
  module V1
    class MessagesController < ApiController
      before_action :set_parent_user, only: [:index]
      before_action :set_message, only: [:show]

      def index
        render json: @user.messages.recent, include: :user
      end

      def show
        render json: @message, include: :user
      end

      private
      # index action is expected to be called only nested under a user.
      # Unnested requests to messages index aren't available in API
      def set_parent_user
        @user = User.find(params[:user_id])
      end

      def set_message
        @message = Message.find(params[:id])
      end

    end
  end
end
