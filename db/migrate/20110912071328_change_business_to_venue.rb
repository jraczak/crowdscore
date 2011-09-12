class ChangeBusinessToVenue < ActiveRecord::Migration
  def change
    rename_table :businesses, :venues
  end
end
