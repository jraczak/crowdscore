class AddFactualCategoryIdToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :factual_category_id, :integer

  end
end
