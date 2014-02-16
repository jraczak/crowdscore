class AddEmailPreferencesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :receive_follower_emails, :boolean, default: true
    add_column :users, :receive_product_emails, :boolean, default: true
  end
end
