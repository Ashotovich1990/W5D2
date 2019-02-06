class ApplicationController < ActionController::Base
  helper_method :current_user, :logged?

  def login(user)
    session[:session_token] = user.resset_session_token! 
    @current_user = user 
  end 

  def logout 
    current_user.resset_session_token! 
    session[:session_token] = nil 
    @current_user = nil 
  end 

  def logged? 
    !!current_user
  end 

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_login 
    redirect_to new_session_url unless logged?
  end
  
end
