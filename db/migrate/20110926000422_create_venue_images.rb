class CreateVenueImages < ActiveRecord::Migration
  def change
    create_table :venue_images do |t|
      t.string :image_file
      t.string :caption
      t.references :venue

      t.timestamps
    end
    add_index :venue_images, :venue_id
  end
end
