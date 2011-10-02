class Venue < ActiveRecord::Base
  default_scope order(:name)

  belongs_to :venue_category
  belongs_to :venue_subcategory

  has_many :venue_images, :class_name => 'VenueImage'

  validates :name, :address1, :city, :state, :zip, :venue_category, presence: true
  validates :url, format: { with: /^https?:\/\//, allow_blank: true, message: "URL must contain 'http://'" }

  def full_category_name
    full_name = venue_category.name
    full_name += " - #{venue_subcategory.name}" if venue_subcategory.present?
    full_name
  end
end
