class MessagesController < ApplicationController
  skip_before_action :authenticate!, only: [:index, :show]
  before_action :set_message, only: [:show, :destroy]
  before_action :check_delete_authorization, only: [:destroy]
  before_action :user_filter, only: [:index]

  # GET /messages
  # GET /messages.json
  def index
    @messages = if @user.present?
                  Message.recent.by_user(@user)
                else
                  signed_in? ? current_user.followed_messages.recent : Message.recent
                end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    def check_delete_authorization
      redirect_to(@message, flash: { error: 'Unauthorized' }) unless @message.can_be_deleted_by?(current_user)
    end

    def user_filter
      @user = params.has_key?(:user_id) ? User.find_by_id(params[:user_id]) : nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content, :user_id)
    end
end
