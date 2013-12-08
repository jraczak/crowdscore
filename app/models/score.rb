class Score < ActiveRecord::Base

belongs_to :venue_score
has_one :score_category

validates :value, presence: true

end
