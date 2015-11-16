class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    puts auth
    session[:omniauth] = auth.except('extra')
    user = User.sign_in_from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to "/edit", id: user.id
  end



  def destroy
    session[:user_id] = nil
    session[:omniauth] = nil
    redirect_to root_url, notice: "SIGNED OUT"
  end
end