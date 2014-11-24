class CreateVenueTagCategories < ActiveRecord::Migration
  def change
    create_table :venue_tag_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
