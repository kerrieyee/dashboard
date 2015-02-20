class SessionsController < ApplicationController
  def create
    ouath = request.env["omniauth.auth"]
    user = User.first_or_create(uid: ouath.uid, github_handle: ouath[:info].nickname)
    user.token = ouath[:credentials].token
    user.save

    session[:user_id] = user.id
    redirect_to root_url
    # render :text => request.env["omniauth.auth"].to_yaml
  end

  private
  def user_params
    params.permit(:uid, :github_handle, :code, :state, :provider, :token)
  end
end