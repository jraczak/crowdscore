# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

default_venue_categories = {
  "Restaurant" => ["American (New)", "American (Traditional)", "Bakery", "Barbecue", "Buffet", "Burgers", "Cafeteria", "Cajun", "Caribbean", "Chinese", "Coffee/Cafe", "Cuban", "Deli" , "Dessert", "Diner" , "Doughnut Shop", "Ethiopian", "Fast Food", "Food Stand/Cart", "French" , "German", "Greek", "Hot Dogs", "Ice Cream & Frozen Yogurt", "Indian" , "Irish", "Italian", "Jamaican", "Japanese/Sushi", "Juice & Smoothie Shop", "Korean", "Latin American", "Mongolian", "Mexican" , "Middle Eastern", "Pizza", "Sandwich Shop", "Seafood", "South American", "Spanish" , "Steakhouse", "Swedish", "Tapas", "Thai", "Vegan", "Vegetarian", "Vietnamese", "Bar Food", "Swiss", "Dim Sum", "Pan Asian/Pacific Rim", "Belgian", "Southwestern/Tex Mex", "Health Food", "Wings", "Noodle Shop", "Brazilian", "Argentinian", "British/English", "Breakfast", "Mediterranean", "Salads", "Chicken", "Southern Food", "Eclectic", "Soup"],
  "Bar & Nightlife" => ["Beer Garden", "Brewery", "Comedy Clubs", "Dance Clubs", "Dive Bar", "Gay & Lesbian", "Hookah Bar", "Jazz & Blues", "Karaoke", "Lounge", "Music Venue", "Piano Bar", "Pool Halls", "Pubs", "Sports Bar", "Themed Bar", "Wine Bar"],
  "Personal Service" => ["Barbershop", "Day Spa", "Eyebrow Threading", "Hair Removal", "Hair Salon", "Massage Parlor", "Medical Spa", "Nail Salon", "Piercing", "Tanning", "Tattoo"],
  "Hotel & Resort"=> []
}

old_count = VenueSubcategory.count
default_venue_categories.each do |name, subs|
  puts "Updating #{name} subcategories..."
  cat = VenueCategory.find_or_create_by_name(name)
  subs.each do |sub|
    cat.venue_subcategories.find_or_create_by_name(sub)
  end
end
new_count = VenueSubcategory.count

puts "#{ new_count - old_count } subcategories were added"

prompt_mappings = {
  "Restaurant" => ["Food", "Service", "Atmosphere", "Value"],
  "Bar & Nightlife" => ["Music", "Atmosphere", "Bar Speed", "Crowd"],
  "Personal Service" => ["Temp 1", "Temp 2", "Temp 3", "Temp 4"],
  "Hotel & Resort" => ["Service", "Location", "Comfort", "Cleanliness"]
}

prompt_mappings.each do |name, prompts|
  cat = VenueCategory.find_by_name(name)

  puts "Updating #{name} prompts..."
  prompts.each_with_index do |prompt, i|
    field = "prompt#{i + 1}".to_sym
    cat.send("#{field}=".to_sym, prompt) if cat.send(field) != prompt
    cat.save!
  end
end

puts "Done!"
