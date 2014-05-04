class Score < ActiveRecord::Base

belongs_to :venue_score
belongs_to :venue
belongs_to :score_category
belongs_to :user

validates_presence_of :value, :score_category_id, :venue_id

end
