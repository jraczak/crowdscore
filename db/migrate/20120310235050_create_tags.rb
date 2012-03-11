class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references :tag_category
      t.string :name

      t.timestamps
    end
    add_index :tags, :tag_category_id
    add_index :tags, :name

    create_table :tags_venues, id: false do |t|
      t.references :tag
      t.references :venue
    end
    add_index :tags_venues, :tag_id
    add_index :tags_venues, :venue_id
  end
end
