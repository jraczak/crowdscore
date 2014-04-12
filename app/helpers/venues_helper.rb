module VenuesHelper
  
  def get_score_categories
    @score_categories = []
    if resource.venue_subcategory.score_categories.any?
      resource.venue_subcategory.score_categories.each do |sc|
        @score_categories << sc
      end
    else
      resource.venue_category.score_categories.each do |sc|
        @score_categories << sc
      end
    end
  end
  
  def get_score_summaries
    get_score_categories
    @scores = []
     
  end
  
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
end
