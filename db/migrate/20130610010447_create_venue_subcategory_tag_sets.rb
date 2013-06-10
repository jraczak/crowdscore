class CreateVenueSubcategoryTagSets < ActiveRecord::Migration
  def change
    create_table :venue_subcategory_tag_sets do |t|
      t.integer :venue_subcategory_id
      t.string :name

      t.timestamps
    end
  end
end
