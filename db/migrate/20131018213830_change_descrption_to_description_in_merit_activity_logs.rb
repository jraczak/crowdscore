class ChangeDescrptionToDescriptionInMeritActivityLogs < ActiveRecord::Migration
  def up
    rename_column :merit_activity_logs, :descrption, :description
  end

  def down
  end
end
