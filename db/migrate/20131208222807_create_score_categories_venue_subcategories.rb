class CreateScoreCategoriesVenueSubcategories < ActiveRecord::Migration
  def up
    create_table :score_categories_venue_subcategories, id: false do |t|
      t.integer :score_category_id
      t.integer :venue_subcategory_id
    end
  end

  def down
  end
end
