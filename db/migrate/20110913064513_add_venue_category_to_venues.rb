class AddVenueCategoryToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :venue_category_id, :integer
    add_index :venues, :venue_category_id
  end
end
