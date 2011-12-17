class VenuesController < InheritedResources::Base
  include VenueControllerAdditions
  actions :index, :show, :new, :create
  before_filter :authenticate_user!, :except => [:index, :show, :search]

  def search
    @venues = VenueSearch.search(params[:q], params[:page])
  end

  private

  def collection
    @venues ||= Venue.active.page(params[:page])
  end

  def resource
    @venue ||= Venue.active.find(params[:id])
  end
end
