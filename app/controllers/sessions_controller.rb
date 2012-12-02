class SessionsController < ApplicationController
  def new
  end

  def callback
    auth = request.env['omniauth.auth']
    @user = User.find_by_uid(auth['uid']) || User.create_via_omniauth(auth)
    sign_in(:user, @user)
    redirect_to dashboard_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
