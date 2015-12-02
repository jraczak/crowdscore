class List < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :venues
  attr_accessible :name, :description

  scope :by_recent, order('updated_at DESC')
  
  has_many :list_likes, dependent: :destroy
  has_many :liked_by, through: :list_likes, source: :user
  has_many :featured_lists
  
  validates :name, :user, presence: true
  validates :name, length: { maximum: 40 }
  validates :description, length: { maximum: 100 }

  # after_save :reindex_list
  # before_destroy :decrement_counter
  
  def as_json(options = {})
    super({ methods: :venue_ids }.merge(options))
  end
  
  def facebook_description
    user = self.user 
    if user.lists.count > 1
      "#{self.name} is one of #{user.username}'s #{user.lists.count} curated lists on Crowdscore. Join today to start building lists of your own."
    else
      "#{self.name} is a list curated by #{user.username} on Crowdscore. Join today to start building lists of your own."
    end
  end
  
  private
  
  #def reindex_list
  #  index!
  #end  
  
  
end
