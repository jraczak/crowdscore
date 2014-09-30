class AddActiveToFeaturedVenues < ActiveRecord::Migration
  def change
    add_column :featured_venues, :active, :boolean

  end
end
