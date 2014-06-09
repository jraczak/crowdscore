class CreateFactualCrowdscoreMaps < ActiveRecord::Migration
  def change
    create_table :factual_crowdscore_maps do |t|
      t.integer :factual_id
      t.integer :venue_subcategory_id
      t.text :description

      t.timestamps
    end
    
    add_index :factual_crowdscore_maps, [:factual_id, :venue_subcategory_id], name: 'index_factual_crowdscore_maps_on_ids', unique: true
  end
end
