class AddDefaultValueForActiveToFeaturedVenues < ActiveRecord::Migration
  def change
    change_column :featured_venues, :active, :boolean, :default => false
  end
end
