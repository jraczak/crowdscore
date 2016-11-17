module API
  class VenuesController < ApplicationController
    respond_to :json
    
    def index
      @venues = Venue.limit(10)
      render json: @venues
      #respond_to do |format|
      #  format.json { render :json => venue }
      #end
    end
    
    def show
      @venue = Venue.find(params[:id])
      render json: @venue, status: 200
      #respond_to do |format|
      #  format.json { render :json => venue }
      #end
    end
  
  end
end