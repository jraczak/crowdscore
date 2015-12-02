class FeaturedList < ActiveRecord::Base

  belongs_to :list
  
  attr_accessible :list_id, :description, :priority, :city, :state, :active, :name, :user_id
end
