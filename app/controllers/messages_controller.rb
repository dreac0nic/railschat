class MessagesController < ApplicationController
  before_filter :authenticate_user # Except show!
  
  def create
    @message = Message.new message_params

    @message.user_id = @current_user.id

    if @message.save
      flash[:notice] = "Message posted!"
    else
      flash[:notice] = "There was a problem posting your message. :("
    end

    redirect_to @message.room
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id)
  end
end
