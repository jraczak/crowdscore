class ChangeFactualIdToFactualCategoryId < ActiveRecord::Migration
  def up
    rename_column :factual_crowdscore_maps, :factual_id, :factual_category_id
  end

  def down
  end
end
