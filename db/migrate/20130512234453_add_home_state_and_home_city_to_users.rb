class AddHomeStateAndHomeCityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_state, :string

    add_column :users, :home_city, :string

  end
end
