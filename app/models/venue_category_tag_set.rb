class VenueCategoryTagSet < ActiveRecord::Base

  ## VenueCategoryTagSets contain the base set of
  ## tags available to all venues within a given
  ## venue_category.
  
  belongs_to :venue_category
  has_many :tags
  
  validates :venue_category_id, presence: true

end
