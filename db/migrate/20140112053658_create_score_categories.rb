class CreateScoreCategories < ActiveRecord::Migration
  def change
    create_table :score_categories do |t|
      t.string :name
      t.text :description
      t.integer :venue_category_id
      t.integer :venue_subcategory_id
      
      t.timestamps
    end
  end


end
