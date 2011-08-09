class AddBirthdayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birth_month, :string
    add_column :users, :birth_day, :integer
  end
end
