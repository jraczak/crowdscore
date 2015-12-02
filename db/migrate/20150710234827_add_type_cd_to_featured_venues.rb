class AddTypeCdToFeaturedVenues < ActiveRecord::Migration
  def change
    add_column :featured_venues, :type_cd, :integer

  end
end
