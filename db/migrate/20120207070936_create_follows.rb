class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :follower
      t.references :followed

      t.timestamps
    end
    add_index :follows, :follower_id
    add_index :follows, :followed_id
  end
end
