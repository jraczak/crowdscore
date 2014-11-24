class ChangeTagCategoryIdToVenueTagCategoryIdForVenueTags < ActiveRecord::Migration
  
  def change
    change_table :venue_tags do |t|
      t.rename :tag_category_id, :venue_tag_category_id
    end
  end

end
