class CreateListsVenuesTable < ActiveRecord::Migration
  def change
    create_table :lists_venues, id: false, force: true do |t|
      t.integer :list_id
      t.integer :venue_id
    end

    add_index :lists_venues, :list_id
    add_index :lists_venues, :venue_id
  end
end
