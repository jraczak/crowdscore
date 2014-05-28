module UserDashboardHelper

  def get_restaurant_recommendations
    rec_search = Venue.search do
      with :venue_category_id, current_user.liked_venue_categories[1]
    end
    @recs = rec_search.results
  end

end
