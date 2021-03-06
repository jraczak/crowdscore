class VenueScore < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user
  has_many :scores, dependent: :destroy

  validates :user, :venue, presence: true
  
  ## Remove the score1-score4 attributes for new venue_score architecture
  #validates :score1, :score2, :score3, :score4, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  #validates :user_id, uniqueness: { scope: :venue_id }

  before_save :compute_score
  after_save :trigger_venue_recomputation

  private

  def compute_score
    #self.computed_score = [score1, score2, score3, score4].map! { |score| score * 2.5 }.inject(&:+).ceil
  end

  def trigger_venue_recomputation
    #venue.recompute_score!
  end
end
