class Admin::VenueCategoriesController < InheritedResources::Base

  def index
    @venue_categories = VenueCategory.all
  end

end