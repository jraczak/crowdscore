class AddNeighborhoodsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :neighborhoods, :text

  end
end
