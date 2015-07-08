class Admin::VenuesController < InheritedResources::Base
  include VenueControllerAdditions
  before_filter :authorize_admin!

  with_role :admin
  
  def create
    # Geocode the venue first
    #@venue = Venue.new(params[:venue])
    logger.debug "Attempting to geocode venue based on params..."
    full_address = "#{params[:venue][:address1]},
                    #{params[:venue][:address2]}, 
                    #{params[:venue][:city]}, 
                    #{params[:venue][:state]}, 
                    #{params[:venue][:zip]}"
    geocode_results = Geokit::Geocoders::GoogleGeocoder.geocode(full_address)
    logger.debug "Instantiating a blank venue..."
    @venue = Venue.new
    logger.debug "Assigning coordinates to blank venue..."
    @venue.latitude = geocode_results.lat
    @venue.longitude = geocode_results.lng
    logger.debug "Attempting to assign attributes to venue without save..."
    @venue.assign_attributes(params[:venue])
    logger.debug "Attempting to save venue..."
    @venue.save!
    redirect_to @venue
  end

  private

  def collection
    @venues ||= end_of_association_chain.page(params[:page])
  end
end
