class AddUserToVenueImages < ActiveRecord::Migration
  def change
    add_column :venue_images, :user_id, :integer
  end
end
