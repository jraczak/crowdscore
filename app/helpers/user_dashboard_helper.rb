module UserDashboardHelper

  def get_restaurant_recommendations(user)
    location = user_location_data
    
      rec_search = Venue.search do
        with :venue_subcategory_id, user.liked_venue_categories["restaurant"][0] unless user.liked_venue_categories.empty?
        with(:location).in_radius(location["lat"], location["lng"], 5) unless location == false
      end

    @recs = rec_search.results
  end
  
  def where_am_i
    #ip = "162.222.72.33" #request.env['REMOTE_ADDR']
    @location = Geokit::Geocoders::IpGeocoder.geocode(request.env['REMOTE_ADDR'])
    @status = @location.success
  end
  
  def dashboard_salutation
    if user_time_zone
      numeric_time = Time.zone.now.in_time_zone(user_time_zone).strftime("%k").to_i
    end
    name = current_user.first_name
    case numeric_time
      when 0..5
        return "Hey there, night owl"
      when 5..12
        return "Good morning, #{name}"
      when 12..18
        return "Good afternoon, #{name}"
      when 18..23
        return "Good evening, #{name}"
      else
        return "Hi, #{name}"
      end
  end
  
  def current_meal
    
    current_time = Time.parse(time_at_user).strftime("%k").to_i unless time_at_user == false
    case current_time
      when 17..22
        return "dinner"
      when 5..11
        return "coffee or breakfast"
      when 11..17
        return "lunch"
      else
        return false
      end
  end

  def render_dashboard_story(story)
    puts story.class
    case story.class.to_s
    when "Tip"
      render "user_dashboard/tip_card", story: story
    when "List"
      render "user_dashboard/list_card", story: story
    when "VenueScore"
      render "user_dashboard/venue_score_card", story: story
    end
  end

end
