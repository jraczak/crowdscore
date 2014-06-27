class AddHoursWithNamesToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :hours_with_names, :text

  end
end
