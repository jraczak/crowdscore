class AddPropertiesToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :properties, :text

  end
end
