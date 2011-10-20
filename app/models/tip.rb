class Tip < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user

  validates :venue, :user, presence: true
  validates :text, presence: true, length: { maximum: 100 }
  validates :user_id, uniqueness: { scope: :venue_id }
end
