class VenueSubcategory < ActiveRecord::Base
  default_scope order(:name)

  belongs_to :venue_category
  has_many :venues

  validates :name, :venue_category, presence: true
end
