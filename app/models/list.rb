class List < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :venues
  attr_accessor :description

  validates :name, :user, presence: true

  def as_json(options = {})
    super({ methods: :venue_ids }.merge(options))
  end
end
