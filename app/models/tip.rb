class Tip < ActiveRecord::Base
  attr_writer :current_user_id # this is definitely not ideal

  scope :by_recent, order('created_at DESC')
  scope :by_likes, order('tip_likes_count DESC')

  belongs_to :venue
  belongs_to :user

  has_many :tip_likes, dependent: :destroy
  has_many :liked_by, through: :tip_likes, source: :user

  validates :venue, :user, presence: true
  validates :text, presence: true, length: { maximum: 100 }

  after_save :reindex_venue
  after_destroy :reindex_venue

  def as_json(options = nil)
    methods = []
    methods << :can_upvote if @current_user_id.present?
    super(methods: methods, include: { user: { only: :username } })
  end

  def can_upvote(user = nil)
    current_id = user.present? ? user.id : @current_user_id
    logger.info "CURRENT: #{current_id}"
    logger.info "TIP CREATOR: #{user_id}"
    current_id && user_id != current_id && !liked_by_ids.include?(current_id)
  end

  private

  def reindex_venue
    venue.index!
  end
end
