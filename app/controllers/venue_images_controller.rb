class VenueImagesController < InheritedResources::Base
  belongs_to :venue
  actions :new, :create

  before_filter :authenticate_user!
end
