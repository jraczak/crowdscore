class AddVenueCategoryIdToScoreCategories < ActiveRecord::Migration
  def change
    add_column :score_categories, :venue_category_id, :integer

  end
end
