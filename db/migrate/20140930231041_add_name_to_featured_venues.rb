class AddNameToFeaturedVenues < ActiveRecord::Migration
  def change
    add_column :featured_venues, :name, :string

  end
end
