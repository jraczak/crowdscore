class VenueSubcategoryTagSet < ActiveRecord::Base

  belongs_to :venue_subcategory
  has_many :tags
  
  validates :venue_subcategory_id, presence: true

end
