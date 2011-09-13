class Venue < ActiveRecord::Base
  belongs_to :venue_category

  validates :name, :address1, :city, :state, :zip, :venue_category, presence: true
  validates :url, format: { with: /^https?:\/\//, allow_blank: true, message: "URL must contain 'http://'" }
end
