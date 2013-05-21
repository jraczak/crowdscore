class UpgradeMeritTo150 < ActiveRecord::Migration
  def up
    remove_column :merit_actions, :log
    create_table 	"merit_activity_logs", :force => true do |t|
      t.integer 	"action_id"
      t.string 		"related_change_type"
      t.integer 	"related_change_id"
      t.string 		"descrption"
      t.datetime 	"created_at"
    end
  end

  def down
  end
end
