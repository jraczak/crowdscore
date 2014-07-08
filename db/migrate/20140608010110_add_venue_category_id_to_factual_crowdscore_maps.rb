class AddVenueCategoryIdToFactualCrowdscoreMaps < ActiveRecord::Migration
  def change
    add_column :factual_crowdscore_maps, :venue_category_id, :integer

  end
end
