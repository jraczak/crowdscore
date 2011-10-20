class AddComputedScoreToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :computed_score, :integer
  end
end
