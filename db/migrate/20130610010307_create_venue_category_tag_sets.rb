class CreateVenueCategoryTagSets < ActiveRecord::Migration
  def change
    create_table :venue_category_tag_sets do |t|
      t.integer :venue_category_id
      t.string :name

      t.timestamps
    end
  end
end
