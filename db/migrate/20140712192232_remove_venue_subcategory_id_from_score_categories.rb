class RemoveVenueSubcategoryIdFromScoreCategories < ActiveRecord::Migration
  def up
    remove_column :score_categories, :venue_subcategory_id
  end

  def down
  end
end
