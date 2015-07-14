class ChangeFeaturedVenueTypeToString < ActiveRecord::Migration
  def up
    change_column :featured_venues, :type, :string
  end

  def down
  end
end
