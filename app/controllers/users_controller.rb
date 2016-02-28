class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:color] = "valid"

      redirect_to root_url, :notice => "Account created successfully! Welcome! :)"
    else
      flash[:color] = "invalid"
      flash[:notice] = "There was a problem with your account. Sorry!" # XXX: Fix to give better errors.

      render "new"
    end
  end
end
