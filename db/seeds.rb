# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

default_venue_categories = {
  "Restaurant" => ["American (New)", "American (Traditional)", "Bakery", "Barbecue", "Buffet", "Burgers", "Cafeteria", "Cajun", "Caribbean", "Chinese", "Coffee/Cafe", "Cuban", "Deli" , "Dessert", "Diner" , "Doughnut Shop", "Ethiopian", "Fast Food", "Food Stand/Cart", "French" , "German", "Greek", "Ice Cream & Frozen Yogurt", "Indian" , "Irish", "Italian", "Jamaican", "Japanese/Sushi", "Juice & Smoothie Shop", "Korean", "Latin American", "Mexican" , "Middle Eastern", "Pizza", "Sandwich Shop", "Seafood", "South American", "Spanish" , "Steakhouse", "Tapas", "Thai", "Vegan", "Vegetarian", "Vietnamese"],
  "Bar & Nightlife" => ["Beer Garden", "Brewery", "Comedy Clubs", "Dance Clubs", "Dive Bar", "Gay & Lesbian", "Hookah Bar", "Jazz & Blues", "Karaoke", "Lounge", "Music Venue", "Piano Bar", "Pool Halls", "Pubs", "Sports Bar", "Themed Bar", "Wine Bar"],
  "Personal Service" => ["Barbershop", "Day Spa", "Eyebrow Threading", "Hair Removal", "Hair Salon", "Massage Parlor", "Medical Spa", "Nail Salon", "Piercing", "Tanning", "Tattoo"],
  "Hotel & Resort"=> []
}

default_venue_categories.each do |name, subs|
  cat = VenueCategory.find_or_create_by_name(name)
  subs.each do |sub|
    cat.venue_subcategories.find_or_create_by_name(sub)
  end
end
