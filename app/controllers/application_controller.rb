class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper :all

  #before_filter :authenticate_on_production
  before_filter :remember_return_to
  #before_filter :configure_permitted_parameters, if: :devise_controller?

  
  ## Some helpers for redirecting users to their previous location after sign in.
  after_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" &&
      request.fullpath != "/users/sign_up" &&
      request.fullpath != "/users/password" &&
      !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    if session[:previous_url] == root_path
      dashboard_path
    else
      if params[:user][:page_action]
      	"#{session[:previous_url]}?page_action=#{params[:user][:page_action]}"
      else
	    session[:previous_url] #|| root_path
      end
    end
  end
  
  def after_confirmation_path_for(resource_name, resource)
    if signed_in?
      dashboard_path
    else
      new_session_path(resource_name)
    end
  end
  
  protected
  
  #def devise_parameter_sanitizer
  #  if resource_class == User
  #    User::ParameterSanitizer.new(User, :user, params)
  #  else
  #    super # Use the default one
  #  end
  #end
  
  #def configure_permitted_parameters
  #  devise_parameter_sanitizer.for(:sign_up) do |u|
  #    u.permit :username, :email, :password, :password_confirmation
  #  end
  #end
  
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
  
  # Define redirect for user to dashboard after signing in
  #def after_sign_in_path_for(devise_resource)
  #  dashboard_path
  #end
end
