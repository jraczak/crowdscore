class AddCountryToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :country, :string

  end
end
