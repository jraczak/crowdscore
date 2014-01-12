class VenueSubcategory < ActiveRecord::Base
  default_scope order(:name)

  belongs_to :venue_category
  has_many :venues
  has_and_belongs_to_many :score_categories
  
  ## VenueSubcategoryTagSets contain additional tags
  ## that a venue_subcategory may have in addition to 
  ## the standard VenueCategoryTagSets held by the 
  ## venue's venue_category.
  has_many :venue_subcategory_tag_sets

  validates :name, :venue_category, presence: true
end
