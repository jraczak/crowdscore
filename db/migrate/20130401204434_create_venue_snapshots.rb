class CreateVenueSnapshots < ActiveRecord::Migration
  def change
    create_table :venue_snapshots do |t|
      t.integer :venue_id
      t.integer :venue_score_count
      t.integer :tip_count
      t.integer :computed_score
      t.integer :score_breakdown1
      t.integer :score_breakdown2
      t.integer :score_breakdown3
      t.integer :score_breakdown4

      t.timestamps
    end
  end
end
