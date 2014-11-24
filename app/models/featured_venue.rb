class FeaturedVenue < ActiveRecord::Base
  extend CarrierWave::Mount
  extend CarrierWaveDirect::Mount
  
  mount_uploader :featured_venue_image, FeaturedVenueImageUploader

  belongs_to :venue
  
  attr_accessible :venue_id, :description, :user_id, :city, :state, :active, :featured_venue_image
end
