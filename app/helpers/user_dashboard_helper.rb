module UserDashboardHelper

  def get_restaurant_recommendations
    location = user_location_data
    
      rec_search = Venue.search do
        with :venue_subcategory_id, current_user.liked_venue_categories[1] unless current_user.liked_venue_categories.empty?
        with(:location).in_radius(location["lat"], location["lng"], 2) unless location == false
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
    current_time = time_at_user #Time.now.strftime("%k").to_i
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

end
