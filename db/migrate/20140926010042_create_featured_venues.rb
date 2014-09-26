class CreateFeaturedVenues < ActiveRecord::Migration
  def change
    create_table :featured_venues do |t|
      t.integer :venue_id
      t.text :description
      t.string :image_url
      t.integer :priority
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
