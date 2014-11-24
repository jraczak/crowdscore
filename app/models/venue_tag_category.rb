class VenueTagCategory < ActiveRecord::Base

has_many :venue_tags
has_and_belongs_to_many :venue_categories

validates :name, presence: true
validates :description, presence: true
end
