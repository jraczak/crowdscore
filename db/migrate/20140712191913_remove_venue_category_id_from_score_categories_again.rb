class RemoveVenueCategoryIdFromScoreCategoriesAgain < ActiveRecord::Migration

  def up
    remove_column :score_categories, :venue_category_id
  end


  def down
  end
end
