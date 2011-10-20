class AddPromptsToVenueCategories < ActiveRecord::Migration
  def change
    add_column :venue_categories, :prompt1, :string
    add_column :venue_categories, :prompt2, :string
    add_column :venue_categories, :prompt3, :string
    add_column :venue_categories, :prompt4, :string
  end
end
