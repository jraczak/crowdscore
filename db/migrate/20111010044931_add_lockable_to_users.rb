class AddLockableToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
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
