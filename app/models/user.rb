class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  # and :omniauthable
  
  before_save :create_permalink
  
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  default_accessible_fields = [:email, :first_name, :last_name, :birth_month,
                               :birth_day, :password, :password_confirmation,
                               :remember_me, :username, :zip_code, :gender, :confirmed_at,
                               :bio, :twitter_username, :permalink] #, :permalink
  admin_only_fields = [:admin]

  attr_accessible *default_accessible_fields
  attr_accessible *(default_accessible_fields + admin_only_fields), :as => :admin

  has_many :venue_scores
  
  has_many :tips
  has_many :tip_likes, dependent: :destroy
  has_many :liked_tips, through: :tip_likes, source: :tip
  has_many :lists

  has_many :my_follows, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :follows, through: :my_follows, source: :followed

  has_many :their_follows, foreign_key: :followed_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :their_follows

  # For now, removing first_name requirement to lower registration barrier.
  # validates :first_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :zip_code, numericality: true, length: { is: 5 }
  validates :birth_month, :birth_day, presence: { if: :birthday_provided? }
  validates :birth_month, inclusion: { in: ::Date::MONTHNAMES, allow_blank: true }
  validates :birth_day, inclusion: { in: 1..31, allow_blank: true }
  validate :check_date_for_realness
  validate :prevent_username_change, on: :update

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    email = conditions.delete(:email)
    where(conditions).where(["lower(email) = :value OR lower(username) = :value", { :value => email.strip.downcase }]).first
  end

  # Public: Verify if a user has permission to submit a score to a given venue.
  # TO-DO: CURRENTLY DOES NOT WORK BETWEEN YEARS. ADD CROSS-YEAR VALIDATION!
  #
  # 1. Using 'has_scored_venue?', check if user has submitted score here before.
  # 2. If user has submitted score before, check if create date is before today.
  # 3. Returns true if never submitted here or if last create date is before today.
  #    Returns false if user has submitted here before and date is not before today.
  
  def can_submit_score?(venue)
    @sorted_scores = self.venue_scores.where(venue_id: venue.id).sort_by { |score| score.created_at }
    if !self.has_scored_venue?(venue.id)
      true
    elsif self.has_scored_venue?(venue.id) && @sorted_scores.last.created_at.to_date.jd < DateTime.now.to_date.jd
      true    
    else
      false
    end
  end
  
  def get_network_activity
    @activities = []
    @follows = self.follows.all
   
    @follows.each do |f|
      f.venue_scores.each do |a|
        @activities << a
      end
      f.tips.each do |t|
        @activities << t
      end
    end
    @activities
  end
  
  # Public: Get the user's full name.
  #
  # Examples:
  #
  #   User.new(first_name: 'Alex', last_name: 'Matthews').full_name
  #   # => 'Alex Matthews'
  #
  # Returns a String containing the full name
  
  def full_name
    "#{first_name} #{last_name}"
  end

  # NEED TO CHANGE THIS BACK TO FRIENDLY URLS AFTER FOLLOWING
  def to_param
    "#{id}"
    #permalink
    #"#{id}-#{username}"
  end

  # Public: lock a user's account and provide a reason why.
  #
  # Returns boolean whether the user's access was locked or not.
  def lock_with_reason!(message)
    if message.present?
      self.lock_reason = message
      lock_access!
    else
      errors[:lock_reason] << "can't be blank"
    end
  end

  def follows?(user)
    follows.include?(user)
  end

  def unlock_access!
    self.lock_reason = nil
    super
  end

  # TODO: TEST THIS!
  def has_scored_venue?(venue)
    VenueScore.exists?(user_id: id, venue_id: venue)
  end

  private

  # Create permalink using provided username for user-friendly URLs
  #
  def create_permalink
    self.permalink = username.downcase
  end
  
  # Check if any facet of a user's birthday is provided.
  #
  # Returns true if birth month or birthday is provided, false otherwise.
  def birthday_provided?
    birth_month? || birth_day?
  end

  # Add an error to this user if the birthday provided is completely impossible
  # (even during a leap year).
  #
  # Examples
  #
  #   check_date_for_realness # when birth_month is "Novembruary"
  #   errors.full_messages.first # => "Birthday should be a real day of the 
  #   year."
  #
  #   check_date_for_realness # when birth_month is "July" and birth day is 37
  #   errors.full_messages.first # => "Birthday should be a real day of the 
  #   year."
  #
  #   check_date_for_realness # when date is real
  #   errors.count # => 0
  #
  # Intended as a validation
  def check_date_for_realness
    if birth_month? && birth_day?
      # test against a leap year so we allow for Feb 29
      Date.new(2008, ::Date::MONTHNAMES.index(birth_month), birth_day)
    end
  rescue
    errors.add(:birthday, "should be a real day of the year.")
  end

  # Add an error if the username is changed after the user is already
  # persisted. (You can bypass this on the command-line by using
  # save(validate: false)
  #
  # Intended as validation
  def prevent_username_change
    if persisted? && username_changed?
      errors.add(:username, "cannot be changed")
    end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if signed_in_resource && (signed_in_resource.facebook_id.blank? || signed_in_resource.facebook_id == data.id)
      signed_in_resource.update_attribute(:facebook_id, data.id)
      signed_in_resource
    elsif user = User.where(facebook_id: data.id).first
      user
    else # Create a user with a stub password. 
      nil
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
        user.first_name = data["first_name"]
        user.last_name = data["last_name"]
        user.username = data["username"]
        user.gender = data["gender"].capitalize
        user.facebook_id = data["id"]
      end
    end
  end
end