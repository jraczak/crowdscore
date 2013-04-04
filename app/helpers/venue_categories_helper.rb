module VenueCategoriesHelper
  
  ## A helper that returns relevant hash tags based on the venue category to be used in Twitter shares
  def hash_tags(venue_category)
    hashtags = []
    hash_tag_string = ""
    if venue_category.name == "Restaurant"
      hashtags << "#restaurants"
    elsif venue_category.name == "Salons & Spas"
      hashtags << ["#salons", "#spas"]
    elsif venue_category.name == "Hotels & Resorts"
      hashtags << ["#hotels", "#resorts"]
    elsif venue_category.name == "Bars & Nightlife"
      hashtags << ["#bars", "#nightlife"]
    end
    hashtags.each do |h|
      hash_tag_string = "#{hash_tag_string} " + "#{h} "
    end
    hash_tag_string
  end
  
end