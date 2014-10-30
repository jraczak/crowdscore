class RenameTagsToVenueTags < ActiveRecord::Migration
  
  def change
    rename_table :tags, :venue_tags
  end


end
