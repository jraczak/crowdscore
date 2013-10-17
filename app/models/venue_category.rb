class VenueCategory < ActiveRecord::Base
  default_scope order(:name)

  has_many :venues
  has_many :venue_subcategories
  
  ## VenueCategoryTagSets contain the base tags
  ## that a venue_category may have which apply to 
  ## all venues within that category. 
  has_many :venue_category_tag_sets

  validates :name, presence: true

end
