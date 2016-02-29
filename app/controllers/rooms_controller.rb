class RoomsController < ApplicationController
  before_filter :authenticate_user, :except => [:index, :show]
  
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find_by_id(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new room_params

    if @room.save
      redirect_to @room, :notice => "Room created successfully!"
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
    @room = Room.find_by_id(params[:id])
  end

  def destroy
  end

  private

  def room_params
    params.require(:room).permit(:topic, :password, :unlisted, :chat_public)
  end
end
