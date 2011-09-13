class Venue < ActiveRecord::Base
  belongs_to :venue_category

  validates :name, :address1, :city, :state, :zip, :venue_category, presence: true
end
