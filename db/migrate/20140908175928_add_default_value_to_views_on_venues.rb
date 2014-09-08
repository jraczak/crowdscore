class AddDefaultValueToViewsOnVenues < ActiveRecord::Migration
  def change
    change_column :venues, :views, :integer, :default => 0
  end
end
