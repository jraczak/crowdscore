class UserDashboardController < ApplicationController
  def show
    # Check to see if a User is signed in.
    # If user is signed in, load up dashboard information. 
    if current_user
      text = "this is my text"
      # If user is NOT signed in, redirect to home page.

      @onboard = true
      
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:notice] = "You must be logged in to view your dashboard."
      redirect_to root_path
    end
  end
end
