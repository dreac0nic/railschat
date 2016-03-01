class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def authenticate_user
    if session[:user_id]
      @current_user = User.find session[:user_id]
      return true
    else
      redirect_to :controller => 'sessions', :action => 'login'
      return false
    end
  end

  def redirect_on_authenticated
    if session[:user_id]
      redirect_to :controller => 'sessions', :action => 'home'
      return false
    else
      return true
    end
  end

  def user_logged_in?
    if session[:user_id]
      @current_user = User.find session[:user_id]
      return true
    else
      return false
    end
  end
end
