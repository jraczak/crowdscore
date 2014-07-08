class AddFactualCategoryIdToVenueCategories < ActiveRecord::Migration
  def change
    add_column :venue_categories, :factual_category_id, :integer

  end
end
