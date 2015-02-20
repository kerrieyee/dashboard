class AuthenticationController < ApplicationController
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      sign_in_and_redirect(:user, authentication.user)
    end

    # lots more code goes here, but you get the point.
    # It authenticates and I can grab the OAuth token from omniauth['credentials']['token']

    # calling a custom method that will later be in the controller, but is instead here to test.
    # save_update_to_github
  end

end