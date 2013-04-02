class VenueSnapshotsController < ApplicationController

  def show
    @venue_snapshot = VenueSnapshot.find(params[:id])  
  end
  
  def new
    @venue_snapshot = VenueSnapshot.new
  end
  
  def create
    @venue_snapshot = VenueSnapshot.create(params[:venue_snapshot])
  end
  
end
