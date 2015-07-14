class ChangeFeaturedVenueTypeCdToType < ActiveRecord::Migration
  def up
    rename_column :featured_venues, :type_cd, :type
  end

  def down
  end
end
