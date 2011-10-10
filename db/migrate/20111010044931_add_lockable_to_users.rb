class AddLockableToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.lockable
      t.string :lock_reason
    end
  end

  def down
    remove_column :users, :locked_at
    remove_column :users, :failed_attempts
    remove_column :users, :unlock_token
    remove_column :users, :lock_reason
  end
end
