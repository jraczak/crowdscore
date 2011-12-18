class Tip < ActiveRecord::Base
  scope :by_recent, order('created_at DESC')
  scope :by_likes, order('tip_likes_count DESC')

  belongs_to :venue
  belongs_to :user

  has_many :tip_likes, dependent: :destroy
  has_many :liked_by, through: :tip_likes, source: :user

  validates :venue, :user, presence: true
  validates :text, presence: true, length: { maximum: 100 }
end
