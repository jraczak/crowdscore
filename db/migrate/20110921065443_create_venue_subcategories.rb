class CreateVenueSubcategories < ActiveRecord::Migration
  def change
    create_table :venue_subcategories do |t|
      t.references :venue_category
      t.string :name

      t.timestamps
    end
    add_index :venue_subcategories, :venue_category_id
  end
end
