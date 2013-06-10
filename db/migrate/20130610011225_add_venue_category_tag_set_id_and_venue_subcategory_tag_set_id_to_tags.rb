class AddVenueCategoryTagSetIdAndVenueSubcategoryTagSetIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :venue_category_tag_set_id, :integer

    add_column :tags, :venue_subcategory_tag_set_id, :integer

  end
end
