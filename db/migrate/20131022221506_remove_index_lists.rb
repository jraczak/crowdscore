class RemoveIndexLists < ActiveRecord::Migration
  def up
    remove_index :lists, :column => :user_id
  end

  def down
  end
end
