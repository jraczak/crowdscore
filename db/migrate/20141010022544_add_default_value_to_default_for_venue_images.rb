class AddDefaultValueToDefaultForVenueImages < ActiveRecord::Migration
  def change
    change_column :venue_images, :default, :boolean, :default => false
  end
end
