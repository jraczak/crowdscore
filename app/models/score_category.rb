class ScoreCategory < ActiveRecord::Base

has_many :scores
has_and_belongs_to_many :venue_categories
has_and_belongs_to_many :venue_subcategories


end
