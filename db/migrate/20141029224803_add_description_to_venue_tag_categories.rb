class AddDescriptionToVenueTagCategories < ActiveRecord::Migration
  def change
    add_column :venue_tag_categories, :description, :text

  end
end
