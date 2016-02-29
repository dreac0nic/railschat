class UsersController < ApplicationController
  before_filter :redirect_on_authenticated, :only => [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:color] = "valid"

      redirect_to root_url, :notice => "Account created successfully! Welcome! :)"
    else
      flash[:color] = "invalid"
      flash[:notice] = "There was a problem with your account. Sorry!" # XXX: Fix to give better errors.

      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:handle, :email, :password, :password_confirmation)
  end

  def redirect_to_root
    redirect_to root_url
  end
end
