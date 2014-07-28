class CreateIndexOnScoreCategoriesVenueCategories < ActiveRecord::Migration
  def up
    add_index :score_categories_venue_categories, :score_category_id, :name => "index_score_categories_venue_categories_on_score_category_id"
    add_index :score_categories_venue_categories, :venue_category_id, :name => "index_score_categories_venue_categories_on_venue_category_id"
  end

  def down
  end
end
