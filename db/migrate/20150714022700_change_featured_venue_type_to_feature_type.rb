class ChangeFeaturedVenueTypeToFeatureType < ActiveRecord::Migration
  def up
    rename_column :featured_venues, :type, :feature_type
  end

  def down
  end
end
