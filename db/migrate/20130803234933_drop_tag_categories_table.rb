class DropTagCategoriesTable < ActiveRecord::Migration
  def up
    drop_table :tag_categories
  end

  def down
  end
end
