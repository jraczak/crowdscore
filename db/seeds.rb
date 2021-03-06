# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

default_venue_categories = {
  "Restaurant" => [["American", 348], ["Barbecue", 349], ["Burgers", 351], ["Chinese", 352], ["Deli", 353], ["Diner", 354], ["Fast Food", 355], ["French", 356], ["Indian", 357], ["Italian", 358], ["Japanese", 359], ["Korean", 360], ["Mexican", 361], ["Middle Eastern", 362], ["Pizza", 363], ["Seafood", 364], ["Steakhouse", 365], ["Sushi", 366], ["Thai", 367], ["Vegan & Vegetarian", 368]],
  "Bar" => [["Hotel Lounge", 313], ["Jazz & Blues Cafe", 314], ["Sports Bar", 315], ["Wine Bar", 316]]
  }
  
  #######################################################
  #Comment out original Restaurant subcategory creation#
  ######################################################
  #"Restaurant" => ["American (New)", "American (Traditional)", "Bakery", "Barbecue", "Buffet", "Burgers", "Cafeteria", "Cajun", "Caribbean", "Chinese", "Coffee/Cafe", "Cuban", "Deli" , "Dessert", "Diner" , "Doughnut Shop", "Ethiopian", "Fast Food", "Food Stand/Cart", "French" , "German", "Greek", "Hot Dogs", "Ice Cream & Frozen Yogurt", "Indian" , "Irish", "Italian", "Jamaican", "Japanese/Sushi", "Juice & Smoothie Shop", "Korean", "Latin American", "Mongolian", "Mexican" , "Middle Eastern", "Pizza", "Sandwich Shop", "Seafood", "South American", "Spanish" , "Steakhouse", "Swedish", "Tapas", "Thai", "Vegan", "Vegetarian", "Vietnamese", "Bar Food", "Swiss", "Dim Sum", "Pan Asian/Pacific Rim", "Belgian", "Southwestern/Tex Mex", "Health Food", "Wings", "Noodle Shop", "Brazilian", "Argentinian", "British/English", "Breakfast", "Mediterranean", "Salads", "Chicken", "Southern Food", "Eclectic", "Soup", "Malaysian", "Gastropub", "Asian Fusion", "African", "Bistro", "Kosher", "Chicken", "Russian", "Turkish", "Bagels", "Pretzels"],
  
  #"Coffee & Tea" => []
  
  ##########################################################################
  #Comment out additional venue categories until we're ready to launch them#
  ##########################################################################
  #"Bar & Nightlife" => ["Beer Garden", "Brewery", "Comedy Clubs", "Dance Clubs", "Dive Bar", "Gay & Lesbian", "Hookah Bar", "Jazz & Blues", "Karaoke", "Lounge", "Music Venue", "Piano Bar", "Pool Halls", "Pubs", "Sports Bar", "Themed Bar", "Wine Bar"],
  #"Personal Service" => ["Barbershop", "Day Spa", "Eyebrow Threading", "Hair Removal", "Hair Salon", "Massage Parlor", "Medical Spa", "Nail Salon", "Piercing", "Tanning", "Tattoo"],
  #"Hotel & Resort"=> []
#}

old_count = VenueSubcategory.count

# Deprecated method for creating subcats that only created by name
#default_venue_categories.each do |name, subs|
#  puts "Updating #{name} subcategories..."
#  cat = VenueCategory.find_or_create_by_name(name)
#  subs.each do |sub|
#    cat.venue_subcategories.find_or_create_by_name(sub)
#  end
#end

# New method for creating subcats that includes factual category ids
default_venue_categories.each do |name, subs|
  puts "Updating #{name} subcategories..."
  cat = VenueCategory.find_or_create_by_name(name)
  subs.each do |subname, subcat|
    unless VenueSubcategory.find_by_factual_category_id(subcat)
      cat.venue_subcategories.create(name: subname, factual_category_id: subcat)
    end
  end
end
new_count = VenueSubcategory.count

puts "#{ new_count - old_count } subcategories were added"

#prompt_mappings = {
#  "Restaurant" => ["Food", "Service", "Atmosphere", "Value"],
#  "Bar & Nightlife" => ["Music", "Atmosphere", "Bar Speed", "Crowd"],
#  "Personal Service" => ["Temp 1", "Temp 2", "Temp 3", "Temp 4"],
#  "Hotel & Resort" => ["Service", "Location", "Comfort", "Cleanliness"]
#}
#
#prompt_mappings.each do |name, prompts|
#  cat = VenueCategory.find_by_name(name)
#
#  puts "Updating #{name} prompts..."
#  prompts.each_with_index do |prompt, i|
#    field = "prompt#{i + 1}".to_sym
#    cat.send("#{field}=".to_sym, prompt) if cat.send(field) != prompt
#    cat.save!
#  end
#end

puts "Skipping tag catgories for now..."
#puts "Adding default venue tag categories..."

#tag_categories = {
#  "Has" => [
#    "Outdoor Seating",
#    "Live Music",
#    "Full Bar",
#    "Bright Lighting",
#    "Low Lighting",
#    "Happy Hour Specials",
#    "Delivery",
#    "Take-out",
#    "Extensive Menu",
#    "Small Menu",
#    "Extensive Wine List",
#    "Extensive Beer List",
#    "Wi-Fi"
#  ],
#  "Good For" => [
#    "Families",
#    "Dates",
#    "Parties",
#    "Large Parties",
#    "Girl's Night Out",
#    "Guy's Night Out"
#  ],
#  "Not So Good For" => [
#    "Families",
#    "Dates",
#    "Large Parties"
#  ],
#  "Serves" => [
#    "Liquor",
#    "Appetizers",
#    "Breakfast",
#    "Brunch",
#    "Lunch",
#    "Dinner",
#    "Dessert",
#    "Tapas",
#    "Bar Food",
#    "Beer",
#    "Wine"
#  ],
#  "Accepts" => [
#    "Visa",
#    "Mastercard",
#    "AMEX",
#    "Discover",
#    "Diner's Club",
#    "Cash",
#    "Reservations"
#  ]
#}

#tag_categories.each do |cat, tags|
#  category = TagCategory.find_or_create_by_name(cat)
#  tags.each do |tag_name|
#    VenueTag.find_or_create_by_name_and_tag_category_id(tag_name, category.id)
#  end
#end

puts "Done!"
