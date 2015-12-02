class CreateFeaturedLists < ActiveRecord::Migration
  def change
    create_table :featured_lists do |t|
      t.integer :list_id
      t.text :description
      t.integer :priority
      t.string :city
      t.string :state
      t.boolean :active
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
