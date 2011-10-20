class CreateVenueScores < ActiveRecord::Migration
  def change
    create_table :venue_scores do |t|
      t.references :venue
      t.references :user
      t.integer :computed_score
      t.integer :score1
      t.integer :score2
      t.integer :score3
      t.integer :score4

      t.timestamps
    end
    add_index :venue_scores, :venue_id
    add_index :venue_scores, :user_id
  end
end
