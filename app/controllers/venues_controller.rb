class VenuesController < InheritedResources::Base
  include VenueControllerAdditions
  actions :index, :show, :new, :create
  before_filter :authenticate_user!, :except => [:index, :show, :search]

  def search
    if params[:zip].blank? && params[:latitude].blank?
      flash[:notice] = 'You must include a location to search.'
      return redirect_to(root_path)
    end

    @venues = VenueSearch.search(params)
  end

  private

  def collection
    @venues ||= Venue.active.page(params[:page])
  end

  def resource
    @venue ||= Venue.active.find(params[:id])
  end
end
