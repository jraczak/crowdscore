class ChangeImageUrlToFeaturedVenueImage < ActiveRecord::Migration
  
  def change
    rename_column :featured_venues, :image_url, :featured_venue_image  
  end


end
