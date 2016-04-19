class SessionsController < ApplicationController
  def create
    user = User2.from_omniauth(env["omniauth.auth"])
    if(user != FALSE)
      session[:user_id] = user.id
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
