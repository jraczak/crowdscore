class Admin::VenuesController < InheritedResources::Base
  before_filter :authorize_admin!

  private

  def collection
    @venues ||= end_of_association_chain.page(params[:page])
  end
end
