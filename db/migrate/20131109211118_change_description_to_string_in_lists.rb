class ChangeDescriptionToStringInLists < ActiveRecord::Migration
  def up
    change_column :lists, :description, :string
  end

  def down
    change_column :lists, :description, :text
  end
end
