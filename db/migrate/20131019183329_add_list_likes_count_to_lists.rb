class AddListLikesCountToLists < ActiveRecord::Migration
  
  def self.up
    add_column :lists, :list_likes_count, :integer, :default => 0
    
    
  end
  
  def self.down
    remove_column :lists, :list_likes_count
  end
  
end
