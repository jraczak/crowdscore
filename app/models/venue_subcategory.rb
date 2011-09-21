class VenueSubcategory < ActiveRecord::Base
  belongs_to :venue_category
  has_many :venues

  validates :name, :venue_category, presence: true
end
