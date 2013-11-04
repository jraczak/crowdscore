class ChangeFacebookIdFormatInUsers < ActiveRecord::Migration
  def up
    change_column :users, :facebook_id, :bigint
  end

  def down
    change_column :users, :facebook_id, :integer
  end
end
