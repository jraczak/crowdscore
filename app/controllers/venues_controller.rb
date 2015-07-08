class VenuesController < InheritedResources::Base
  include VenueControllerAdditions
  actions :index, :show, :new, :edit, :update #create
  before_filter :authenticate_user!, except: [:index, :show, :search]
  
  def search
    if params[:zip].blank? && params[:latitude].blank?
      flash[:notice] = 'You must include a location to search.'
      return redirect_to(root_path)
    end

    #@venues = VenueSearch.search(params)
    @venues = Venue.search(params[:q], params[:zip], "standard search").records.to_a
    @json = @venues.to_gmaps4rails
  end
  
  def create
    # Geocode the venue first
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
  
  def show
    tracker = Mixpanel::Tracker.new(ENV['MIXPANEL_PROJECT_TOKEN'])
    agent = request.env['HTTP_USER_AGENT']
    @higher_scored_venues = Venue.higher_scored_than(resource, 10)
    @json = resource.to_gmaps4rails
    resource.views += 1
    resource.save!
    tracker.track(0, 'Viewed Venue', {
      'User Agent' => "#{agent}"
      })
  end
  
  def edit
    @uploader.update_attribute :key, params[:key]
    super
  end
  
  def create_snapshot
    venue = Venue.find(params[:id])
    snapshot = VenueSnapshot.new(
    							venue_id: venue.id,
    							venue_scores_count: venue.venue_scores.count,
    							tip_count: venue.tips.count,
    							current_crowdscore: venue.computed_score,
    							score_breakdown1: venue.score_breakdown1,
    							score_breakdown2: venue.score_breakdown2,
    							score_breakdown3: venue.score_breakdown3,
    							score_breakdown4: venue.score_breakdown4
    							)
    snapshot.save!
  end
  

  private

  def collection
    @venues ||= Venue.active.alphabetical.page(params[:page])
  end

  def resource
    @venue ||= Venue.active.find(params[:id])
  end

  def as_role
    resource.presisted? ? { as: :regular_user_editing } : super
  end
  
end
