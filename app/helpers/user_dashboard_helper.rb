module UserDashboardHelper

  def get_restaurant_recommendations(user)
    location = user_location_data
    all_results = []
    @cards = []
      
      
      unless user.liked_venue_categories.empty? || location == false
        user.liked_venue_categories["restaurant"].each do |lvc|
          rec_search = Venue.search do
            #with :venue_subcategory_id, VenueSubcategory.find_by_factual_category_id(lvc).id
            with :venue_subcategory_id, VenueSubcategory.find(lvc).id
            with(:location).in_radius(location["lat"], location["lng"], 5) unless location == false
          end
          all_results << rec_search.results unless rec_search.results.empty?
        end
      end

    all_results.each do |r|
      @cards << Venue.find(r[0]["id"]) unless current_user.venue_scores.where(venue_id: r[0]["id"]).any?
    end
    
  end
  
  def get_featured_venue
    fv = FeaturedVenue.arel_table
    location = user_location_data
    @featured_venue = FeaturedVenue.where(fv[:city].matches("%#{location['city']}"), fv[:state].matches("%#{location['state']}"), active: true).sample if location
    
    #@featured_venues = local_features.where(active: true)
  end
  
  def distance_to_featured_venue
    location = Geokit::Geocoders::GoogleGeocoder.geocode(user_location_data["full_address"])
    location.distance_to(@featured_venue.venue).round(1)
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
  
  def module_header(module_type)
    case module_type
      when "nearby_venues"
        return "Similar places nearby"
      when "cuisine_recommendations"
        return "New places to try"
    end
  end
  
  def module_copy(module_type)
    case module_type
      when "nearby_venues"
        return "These places are similar to #{resource.name} and are nearby."
      when "cuisine_recommendations"
        return "Here are some new places to try based on the cuisines you like."
    end
  end
  
  def distance_from_user(venue)
    if user_location_data
      #user_location = Geokit::LatLng.new(user_location_data[0], user_location_data[1])
      return venue.distance_to([user_location_data["lat"], user_location_data["lng"]]).round(1)
    else
      return
    end
  end

end
