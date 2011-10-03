class Admin::VenuesController < InheritedResources::Base
  include VenueControllerAdditions
  before_filter :authorize_admin!

  with_role :admin

  private

  def collection
    @venues ||= end_of_association_chain.page(params[:page])
  end
end
