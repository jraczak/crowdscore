class VenueScoresController < InheritedResources::Base
  belongs_to :venue
  actions :new, #:create
  before_filter :authenticate_user!

  def create
    build_resource.user = current_user
    create!
    flash[:notice] = "You've earned 1 Karma point for submitting your score!"
  end

end
