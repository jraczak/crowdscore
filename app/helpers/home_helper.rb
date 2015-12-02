module HomeHelper

  def user_location
    #@user_search_location = "#{user_location_data['city']} #{user_location_data['state']}"
    #return "#{user_location_data['city']} #{user_location_data['state']}"
    "#{user_location_data['city']} #{user_location_data['state']}"
  end
  
  def get_new_restaurant_features
    fv = FeaturedVenue.arel_table
    location = user_location_data
    @new_restaurant = FeaturedVenue.where(fv[:city].matches("%#{location['city']}"))
                                   .where(fv[:state].matches("%#{location['state']}"))
                                   .where(fv[:feature_type].matches("new restaurant"))
                                   .where(fv[:active].eq(true)).sample if location

    #@featured_venues = local_features.where(active: true)
  end
  
  def get_featured_restaurant
    fv = FeaturedVenue.arel_table
    location = user_location_data
    @featured_restaurant = FeaturedVenue.where(fv[:city].matches("%#{location['city']}"))
                                        .where(fv[:state].matches("%#{location['state']}"))
                                        .where(fv[:feature_type].matches("standard"))
                                        .where(fv[:active].eq(true)).sample if location
  end
  
  def get_local_favorite_restaurants
    fv = FeaturedVenue.arel_table
    location = user_location_data
    @favorite_restaurants = FeaturedVenue.where(fv[:city].matches("%#{location['city']}"))
                                         .where(fv[:state].matches("%#{location['state']}"))
                                         .where(fv[:feature_type].matches("favorite"))
                                         .where(fv[:active].eq(true)) if location
  end

end