class AddHourRangesToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :hour_ranges, :text

  end
end
