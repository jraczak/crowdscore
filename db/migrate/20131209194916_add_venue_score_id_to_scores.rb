class AddVenueScoreIdToScores < ActiveRecord::Migration
  def change
    add_column :scores, :venue_score_id, :integer

  end
end
