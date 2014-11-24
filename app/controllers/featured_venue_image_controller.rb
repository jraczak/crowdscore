class FeaturedVenueImageController < ApplicationController
  
  def new
    @uploader = resource.featured_venue_image
    @uploader.success_action_redirect = edit_admin_featured_venue_url
    @uploader.update_attribute :key, params[:key]
  end
  
  def edit
    @uploader = resource.featured_venue_image
    @uploader.success_action_redirect = edit_admin_featured_venue_url
    @uploader.update_attribute :key, params[:key]
    super
  end

end