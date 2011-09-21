class VenueSubcategoriesController < InheritedResources::Base
  belongs_to :venue_category
  actions :index
  respond_to :json

  def index
    respond_with collection.to_json(:only => [:id, :name])
  end
end
