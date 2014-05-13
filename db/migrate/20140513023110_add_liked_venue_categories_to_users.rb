class AddLikedVenueCategoriesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :liked_venue_categories, :text

  end
end
