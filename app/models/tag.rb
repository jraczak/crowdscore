class Tag < ActiveRecord::Base
  belongs_to :venue_category_tag_set
  belongs_to :venue_subcategory_tag_set
  has_and_belongs_to_many :venues, uniq: true

  validates :name, presence: true
  
  ## CURRENTLY DISABLING METHOD - PREVIOUSLY USED
  ## TO CREATE STRING FOR SEARCH WITHIN VENUE SEARCH. 
  #def full_name
  #  "#{tag_category.name} #{name}"
  #end

  def as_json(options = {})
    super({include: {tag_category: {only: [:name, :id]}}, only: [:name, :id]}.merge(options))
  end
end
