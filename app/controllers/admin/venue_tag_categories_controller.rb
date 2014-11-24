class Admin::VenueTagCategoriesController < InheritedResources::Base
  respond_to :json

  #def index
  #  if params[:venue_id]
  #    venue = Venue.find(params[:venue_id])
  #    respond_with venue.tags
  #  else
  #    respond_with Tag.all
  #  end
  #end

  #def create
  #  venue = Venue.find(params[:venue_id])
  #  tag = Tag.find(params[:tag_id])
  #  venue.tags << tag
  #
  #  render status: :ok, nothing: true
  #end
end