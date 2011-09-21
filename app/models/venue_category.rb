class VenueCategory < ActiveRecord::Base
  has_many :venues
  has_many :venue_subcategories

  validates :name, presence: true
end
