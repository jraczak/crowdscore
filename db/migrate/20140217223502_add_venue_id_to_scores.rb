class AddVenueIdToScores < ActiveRecord::Migration
  def change
    add_column :scores, :venue_id, :integer

  end
end
