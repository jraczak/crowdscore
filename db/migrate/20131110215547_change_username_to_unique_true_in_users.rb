class ChangeUsernameToUniqueTrueInUsers < ActiveRecord::Migration
  def up
    change_column :users, :username, :string, :unique => true
  end

  def down
  end
end
