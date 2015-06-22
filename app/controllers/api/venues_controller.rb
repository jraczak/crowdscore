module API
  class VenuesController < Application Controller
  
    def show
      venue = Venue.find(params[:id])
      render json: venue, status: 200
    end
  
  end
end