class AddFactualIdToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :factual_id, :string

  end
end
