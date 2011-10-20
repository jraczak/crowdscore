class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.references :venue
      t.references :user
      t.string :text

      t.timestamps
    end
    add_index :tips, :venue_id
    add_index :tips, :user_id
  end
end
