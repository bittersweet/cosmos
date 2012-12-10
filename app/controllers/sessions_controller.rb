class SessionsController < ApplicationController
  skip_before_filter :auth_user

  def new
  end

  def callback
    auth = request.env['omniauth.auth']
    @user = User.find_by_uid(auth['uid']) || User.create_via_omniauth(auth)
    sign_in(:user, @user)
    redirect_to dashboard_path
  end
end
