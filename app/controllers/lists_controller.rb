class ListsController < InheritedResources::Base
  before_filter :authenticate_user!
  custom_actions resource: [:add, :remove]

  respond_to :html, :json

  def add
    venue = Venue.find(params[:venue_id])
    resource.venues << venue

    render nothing: true, status: :ok
  end

  def remove
    venue = Venue.find(params[:venue_id])
    resource.venues.delete(venue)

    render nothing: true, status: :ok
  end

  private

  def begin_of_association_chain
    current_user
  end
end
