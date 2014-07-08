class AddFactualCategoryIdToVenueSubcategories < ActiveRecord::Migration
  def change
    add_column :venue_subcategories, :factual_category_id, :integer

  end
end
