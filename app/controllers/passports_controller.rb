class PassportsController < ApplicationController
  before_filter :authenticate_user
  
  def create
    passport = Passport.new passport_params
    passport.user_id = @current_user.id

    if passport.save
      flash[:notice] = "Successfully joined the room!"
    else
      flash[:notice] = "Couldn't join the room! Sorry. :("
    end
    
    redirect_to passport.room
  end

  private

  def passport_params
    params.require(:passport).permit(:room_id)
  end
end
