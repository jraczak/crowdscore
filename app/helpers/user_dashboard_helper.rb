module UserDashboardHelper

  def get_restaurant_recommendations
    rec_search = Venue.search do
      with :venue_category_id, current_user.liked_venue_categories[1]
      with(:location).in_radius(37.5559915, -122.2613072, 10)
    end
    @recs = rec_search.results
  end

end
