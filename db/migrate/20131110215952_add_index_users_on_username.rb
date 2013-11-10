class AddIndexUsersOnUsername < ActiveRecord::Migration
  def up
    add_index :users, :username, unique: true
  end

  def down
  end
end
