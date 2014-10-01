class AddUserIdToFeaturedVenues < ActiveRecord::Migration
  def change
    add_column :featured_venues, :user_id, :integer

  end
end
