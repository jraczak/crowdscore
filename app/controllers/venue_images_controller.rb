class VenueImagesController < InheritedResources::Base
  belongs_to :venue
  actions :new, :create

  before_filter :authenticate_user!

  def create
    build_resource.user = current_user
    create!
  end
end
