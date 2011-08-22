class Admin::DashboardsController < ApplicationController
  before_filter :authorize_admin!
  layout "admin"

  def show
  end
end
