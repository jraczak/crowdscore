class Admin::FeaturedVenuesController < InheritedResources::Base

def create
  create!
  venue = Venue.find(params[:featured_venue][:venue_id])
  @featured_venue.city = venue.city
  @featured_venue.state = venue.state
  @featured_venue.name = venue.name
  @featured_venue.save!
  
end

  def edit
    @uploader = FeaturedVenue.new.featured_venue_image
    @uploader.success_action_redirect = edit_admin_featured_venue_url
    resource.update_attribute :key, params[:key]
    super
  end
  
  def show
    
  end
  
  private
  
  def update_image_url
    @uploader.update_attribute :key, params[:key]
  end

end
 