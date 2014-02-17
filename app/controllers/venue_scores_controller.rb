class VenueScoresController < InheritedResources::Base
  belongs_to :venue
  actions :new #:create
  before_filter :authenticate_user!

  
  def create
  	score_data = eval(params[:score_data])

    @venue_score = VenueScore.new
    @venue_score.venue = Venue.find(params[:venue_id])
    @venue_score.user = current_user
    @venue_score.save!
    
    scores = []
    computed_score = 0
    score_data.each do |sc, sv|
      s = Score.new(score_category_id: sc, value: (sv*10), user_id: current_user.id, venue_id: params[:venue_id])
      s.save!
      computed_score = computed_score + s.value
      scores << s
    end
    
    @venue_score.scores << scores
    @venue_score.computed_score = computed_score / scores.count
    @venue_score.save!
    
    flash[:notice] = "You've earned 1 Karma point for submitting your score!"
  end
  
  
  
  
  #def create
  #  build_resource.user = current_user
  #  create!
  #  flash[:notice] = "You've earned 1 Karma point for submitting your score!"
  #end

end
