module VenuesHelper
  
  def inline_address(venue)
    parts = [venue.address1, venue.address2, "#{venue.city}, #{venue.state} #{venue.zip}"].reject(&:blank?)

    parts.map! { |p| h(p) }
    parts.join(' ').html_safe
    #parts.join('<br />').html_safe
  end
  
  def formatted_inline_address(venue)
    "#{venue.address1} #{venue.address2} <br>
    #{venue.city}, #{venue.state} #{venue.zip}"
  end
  
  def get_active_tag_categories(venue)
    @tag_categories = []
    venue.tags.each do |t|
      unless @tag_categories.include?(t.tag_category)
        @tag_categories << t.tag_category
      end
    end
    @tag_categories
  end
  
  def get_active_tags(venue)
    @tags = venue.tags
  end
  
  def business_hours(venue)
  if venue.hour_ranges.empty?
    return "Unavailable"
  else
    today = Date.today.strftime("%A").downcase
    return "#{Time.parse(venue.hour_ranges[:"#{today}"][:open]).strftime("%l:%M%p")} - #{Time.parse(venue.hour_ranges[:"#{today}"][:close]).strftime("%l:%M%p")}"
    #sets = venue.hours["#{today}"].count
    #if sets == 1
    #  @open_time = venue.hours["#{today}"][0][0]
    #  @close_time = venue.hours["#{today}"][0][1]
    #elsif sets == 2
    #  @open_time = venue.hours["#{today}"][0][0]
    #  @close_time = venue.hours["#{today}"][1][1]
    #end
    
    #@hours = {:open_time => Time.parse(venue.hour_ranges[:"#{today}"][:open]).strftime("%l:%M%p"), :close_time => Time.parse(venue.hour_ranges[:"#{today}"][:close]).strftime("%l:%M%p")}
    #@open_time = Time.parse(venue.hour_ranges[:"#{today}"][:open]).strftime("%l:%M%p")
    #@close_time = Time.parse(venue.hour_ranges[:"#{today}"][:close]).strftime("%l:%M%p")
  end
  end
  
  def get_similar_nearby_venues(venue, _limit = 10)
    #Venue.near([venue.latitude, venue.longitude], 2).where('computed_score > ? AND venue_category_id = ?', venue.computed_score.to_i, venue.venue_category_id).limit _limit
    @cards = Venue.near([venue.latitude, venue.longitude], 2).where(venue_subcategory_id: venue.venue_subcategory_id).limit _limit
  end
  
  def distance_between(primary_venue, nearby_venue)
    primary_venue.distance_to(nearby_venue).round(1)
  end
  
  def venue_time_zone
    NearestTimeZone.to(resource.latitude, resource.longitude)
  end
  
  def open_now?
    unless resource.hour_ranges.empty?
      time = Time.zone.now.in_time_zone(venue_time_zone).strftime("%H%M").to_i
      range = (Time.parse(resource.hour_ranges[:sunday][:open]).strftime("%H%M").to_i..Time.parse(resource.hour_ranges[:sunday][:close]).strftime("%H%M").to_i)
      if time.in?(range)
        return "open"
      else
        return "closed"
      end
    end
  end
  

end
