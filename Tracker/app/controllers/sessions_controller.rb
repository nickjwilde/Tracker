class SessionsController < ApplicationController
  #create a session for the user
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    if(user != FALSE)
      session[:user_id] = user.id
    end
    redirect_to root_path
  end

  #same as above
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
