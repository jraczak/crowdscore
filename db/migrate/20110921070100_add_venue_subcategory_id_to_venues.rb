class AddVenueSubcategoryIdToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :venue_subcategory_id, :integer
    add_index :venues, :venue_subcategory_id
  end
end
