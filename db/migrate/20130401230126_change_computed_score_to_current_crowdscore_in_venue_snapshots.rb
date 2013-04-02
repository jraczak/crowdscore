class ChangeComputedScoreToCurrentCrowdscoreInVenueSnapshots < ActiveRecord::Migration
  def up
    rename_column :venue_snapshots, :computed_score, :current_crowdscore
  end

  def down
    rename_column :venue_snapshots, :current_crowdscore, :computed_score
  end
end
