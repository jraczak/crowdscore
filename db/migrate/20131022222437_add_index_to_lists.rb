class AddIndexToLists < ActiveRecord::Migration
  def change
    add_index :lists, :user_id
  end
end
