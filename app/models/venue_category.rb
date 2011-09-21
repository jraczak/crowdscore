class VenueCategory < ActiveRecord::Base
  default_scope order(:name)

  has_many :venues
  has_many :venue_subcategories

  validates :name, presence: true
end
