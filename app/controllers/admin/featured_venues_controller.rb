class Admin::FeaturedVenuesController < InheritedResources::Base

def create
  create!
  venue = Venue.find(params[:featured_venue][:venue_id])
  @featured_venue.city = venue.city
  @featured_venue.state = venue.state
  @featured_venue.save!
  
end

end
