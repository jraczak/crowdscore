class VenueSnapshotsController < ApplicationController

  def show
    @venue_snapshot = VenueSnapshot.find(params[:id])  
  end
  
  def new
    @venue_snapshot = VenueSnapshot.new
  end
  
  def create(venue)
    @venue_snapshot = VenueSnapshot.new
    @venue_snapshot.update_attributes(
      :venue_id => venue.id,
      :venue_score_count => venue.venue_scores.count,
      :tip_count => venue.tips.count,
      :current_crowdscore => venue.computed_score,
      :score_breakdown1 => venue.score_breakdown1,
      :score_breakdown2 => venue.score_breakdown2,
      :score_breakdown3 => venue.score_breakdown3,
      :score_breakdown4 => venue.score_breakdown4
      )
    @venue_snapshot.save!
  end
  
end
