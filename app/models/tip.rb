class Tip < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user

  validates :venue, :user, presence: true
  validates :text, presence: true, length: { maximum: 100 }
end
