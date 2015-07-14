module HomeHelper

  def get_new_restaurant_features
    fv = FeaturedVenue.arel_table
    location = user_location_data
    @new_restaurant = FeaturedVenue.where(fv[:city].matches("%#{location['city']}"), fv[:state].matches("%#{location['state']}"), feature_type: "new restaurant", active: true).sample if location

    #@featured_venues = local_features.where(active: true)
  end
  
  def get_featured_restaurant
    fv = FeaturedVenue.arel_table
    location = user_location_data
    @featured_restaurant = FeaturedVenue.where(fv[:city].matches("%#{location['city']}"), fv[:state].matches("%#{location['state']}"), feature_type: "standard", active: true).sample if location
  end

end
