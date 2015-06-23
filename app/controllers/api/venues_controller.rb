module API
  class VenuesController < ApplicationController
    respond_to :json
    
    def show
      @venue = Venue.find(params[:id])
      respond_with @venue
      #respond_to do |format|
      #  format.json { render :json => venue }
      #end
    end
  
  end
end