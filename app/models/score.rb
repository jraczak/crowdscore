class Score < ActiveRecord::Base

belongs_to :venue_score
belongs_to :score_category

validates_presence_of :value, :score_category_id

end
