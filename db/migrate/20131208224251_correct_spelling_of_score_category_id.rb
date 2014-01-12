class CorrectSpellingOfScoreCategoryId < ActiveRecord::Migration
  def up
    rename_column :score_categories_venue_categories, :score_cateogry_id, :score_category_id
  end

  def down
  end
end
