class RoomsController < ApplicationController
  before_filter :authenticate_user, :except => [:index, :show]
  
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @message.room_id = @room.id

    # XXX: Dirty implementation, should change filter
    if session[:user_id]
      @current_user = User.find session[:user_id]
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new room_params
    @room.user_id = @current_user.id

    if @room.save
      flash[:notice] = "Room created successfully!"
      redirect_to @room
    else
      flash[:notice] = "Problem creating room!"

      render "new"
    end
  end

  def edit
    @room = Room.find_by_id(params[:id])
  end

  def update
    # I don't remember how to do this. @_@
  end

  def delete
    @room = Room.find(params[:id])
  end

  def destroy
  end

  private

  def room_params
    params.require(:room).permit(:topic, :password, :password_confirmation, :unlisted, :chat_public)
  end
end
