class Score < ActiveRecord::Base

belongs_to :venue_score
belongs_to :score_category

validates :value, presence: true

end
