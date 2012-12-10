class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :auth_user

  private

  def auth_user
    redirect_to login_path if !user_signed_in?
  end
end
