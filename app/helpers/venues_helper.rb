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

end
