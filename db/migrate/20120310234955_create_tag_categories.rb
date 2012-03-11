class CreateTagCategories < ActiveRecord::Migration
  def change
    create_table :tag_categories do |t|
      t.string :name

      t.timestamps
    end
    add_index :tag_categories, :name
  end
end
