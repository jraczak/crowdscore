class CreateVenueCategoriesVenueTagCategories < ActiveRecord::Migration
  
  def change
    create_table :venue_categories_venue_tag_categories, id: false do |t|
      t.belongs_to :venue_category
      t.belongs_to :venue_tag_category
    end
  end

end
