class AddTipLikesCountToTips < ActiveRecord::Migration
  def change
    add_column :tips, :tip_likes_count, :integer, default: 0
  end
end
