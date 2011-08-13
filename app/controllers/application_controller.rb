class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_on_production

  protected

  def authenticate_on_production
    return if Rails.env.development? || Rails.env.test?
    authenticate_or_request_with_http_basic do |username, password|
      username == "crowdscore" && password == "denver"
    end
  end
end
