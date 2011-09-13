# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

default_venues = ["Restaurant", "Bar & Nightlife", "Personal Service", "Hotel & Resort"]

default_venues.each do |name|
  VenueCategory.find_or_create_by_name(name)
end
