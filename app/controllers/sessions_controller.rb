class SessionsController < ApplicationController
  def create
    ouath = request.env["omniauth.auth"]
    user = User.first_or_create(uid: ouath.uid, github_handle: ouath[:info].nickname)
    redirect_to root_url
  end

  private
  def user_params
    params.permit(:uid, :github_handle, :code, :state, :provider)
  end

end