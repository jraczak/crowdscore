class List < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :venues
  attr_accessor :description

  has_many :list_likes, dependent: :destroy
  has_many :liked_by, through: :list_likes, source: :user
  
  validates :name, :user, presence: true

  after_save :reindex_list
  before_destroy :decrement_counter
  
  def as_json(options = {})
    super({ methods: :venue_ids }.merge(options))
  end
  
  
  
end
