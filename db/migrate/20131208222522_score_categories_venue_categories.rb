class ScoreCategoriesVenueCategories < ActiveRecord::Migration
  def up
    create_table :score_categories_venue_categories, id: false do |t|
      t.integer :score_cateogry_id
      t.integer :venue_category_id
    end
  end

  def down
  end
end
