class CreateVenueTagsVenues < ActiveRecord::Migration
  def change
    create_table :venue_tags_venues, id: false do |t|
      t.belongs_to :venue_tag
      t.belongs_to :venue
    end
  end

  def down
  end
end