class VenuesController < InheritedResources::Base
  include VenueControllerAdditions
  actions :index, :show, :new, :create
  before_filter :authenticate_user!, :except => [:index, :show]

  private

  def collection
    @venues ||= end_of_association_chain.page(params[:page])
  end
end
