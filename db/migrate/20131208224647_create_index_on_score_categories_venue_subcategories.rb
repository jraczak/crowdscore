class CreateIndexOnScoreCategoriesVenueSubcategories < ActiveRecord::Migration
  def up
    add_index :score_categories_venue_subcategories, :score_category_id, :name => "index_score_categories_venue_subcategories_on_score_category_id"
    add_index :score_categories_venue_subcategories, :venue_subcategory_id, :name => "index_score_cats_venue_subcats_on_venue_subcategory_id"
  end

  def down
  end
end
