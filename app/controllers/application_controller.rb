class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_on_production
  before_filter :remember_return_to

  protected

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # Use as before_filter to require http basic auth on non-local environments.
  #
  # Returns true or false depending on the environment and whether the user
  # enters the credentials specified.
  def authenticate_on_production
    return if Rails.env.development? || Rails.env.test?
    authenticate_or_request_with_http_basic do |username, password|
      username == "crowdscore" && password == "denver"
    end
  end

  # Use as a before_filter to set up CanCan authorization for admin-only areas.
  def authorize_admin!
    authorize! :manage, :all
  end

  def remember_return_to
    session[:user_return_to] = params[:return_to] if params[:return_to].present?
  end
end
