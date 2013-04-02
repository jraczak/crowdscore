class VenuesController < InheritedResources::Base
  include VenueControllerAdditions
  actions :index, :show, :new, :create, :edit, :update
  before_filter :authenticate_user!, except: [:index, :show, :search]

  def search
    if params[:zip].blank? && params[:latitude].blank?
      flash[:notice] = 'You must include a location to search.'
      return redirect_to(root_path)
    end

    @venues = VenueSearch.search(params)
    #@json = Venue.all.to_gmaps4rails
  end
  
  def get_tag_categories
    @venue ||= Venue.active.find(params[:id])
    tag_categories = []
    @venue.tags.each do |t|
      unless tag_categories.include?(t.name)
        tag_categories << t.name
      end
    end
    tag_categories
  end
  
  def show
    @higher_scored_venues = Venue.higher_scored_than(resource, 10)
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
