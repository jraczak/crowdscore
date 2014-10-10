class AddDefaultToVenueImages < ActiveRecord::Migration
  def change
    add_column :venue_images, :default, :boolean

  end
end
