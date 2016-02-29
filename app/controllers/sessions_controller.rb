class SessionsController < ApplicationController
  before_filter :authenticate_user, :only => [:home, :profile, :settings]
  before_filter :redirect_on_authenticated, :only => [:login, :login_query]
  
  def login
  end

  def login_query
    authorized_user = User.authenticate(params[:name], params[:password])

    if(authorized_user)
      session[:user_id] = authorized_user.id
      redirect_to :action => 'home', :notice => "Welcome back, #{authorized_user.handle}!"
    else
      flash[:notice] = "Invalid username or password!"
      render "login"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end

  def home
  end

  def profile
  end

  def settings
  end
end
