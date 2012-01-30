class List < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :venues

  validates :name, :user, presence: true

  def as_json(options = {})
    super({ methods: :venue_ids }.merge(options))
  end
end
