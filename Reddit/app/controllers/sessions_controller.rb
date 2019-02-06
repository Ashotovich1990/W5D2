class SessionsController < ApplicationController

  def new 
    :new
  end 

  def create 
    user = User.find_by_credentilas(params[:user][:username], params[:user][:password])

    if user 
      login(user)
      redirect_to subs_url
    else 
      flash[:errors] = "Invalid credentials"
      render :new 
    end 
  end

  def destroy 
    logout
    redirect_to new_session_url
  end


end
