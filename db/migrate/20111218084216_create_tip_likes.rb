class CreateTipLikes < ActiveRecord::Migration
  def change
    create_table :tip_likes do |t|
      t.references :tip
      t.references :user

      t.timestamps
    end
    add_index :tip_likes, :tip_id
    add_index :tip_likes, :user_id
  end
end
