class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :home_city, :home_state
  has_merit

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  # and :omniauthable
  
  before_save :create_permalink
  
  # Removing for now because of complications with the invitation process.
  # Downcasing of username has been moved to the controller.
  #before_save :downcase_username, unless: :just_invited?
  
  # MOVING METHOD TO PRIVATE METHOD BELOW TO REMOVE BLOCK
  # before_save { |user| user.username = user.username.downcase }, unless: :just_invited?
  
  devise :invitable, :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :invitable,
         :omniauth_providers => [:facebook]

  default_accessible_fields = [:email, :first_name, :last_name, :birth_month,
                               :birth_day, :password, :password_confirmation,
                               :remember_me, :username, :zip_code, :gender, :confirmed_at,
                               :bio, :twitter_username, :permalink, :home_city, :home_state] #, :permalink
  admin_only_fields = [:admin]

  attr_accessible *default_accessible_fields
  attr_accessible *(default_accessible_fields + admin_only_fields), :as => :admin

  has_many :venue_scores
  has_many :scores
  
  has_many :tips
  has_many :tip_likes, dependent: :destroy
  has_many :liked_tips, through: :tip_likes, source: :tip
  has_many :lists
  has_many :list_likes, dependent: :destroy
  has_many :liked_lists, through: :list_likes, source: :list

  has_many :my_follows, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :follows, through: :my_follows, source: :followed

  has_many :their_follows, foreign_key: :followed_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :their_follows
  
  has_many :invitations, :class_name => self.to_s, :as => :invited_by

  
  validates :first_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true #, uniqueness: true
  # Add a conditional validation on email that allows users who were invited
  # to sign up using an email "already taken", which occurs during the invitation process
  validates :email, uniqueness: true, unless: :was_invited?
  validates :zip_code, numericality: true, length: { is: 5 } unless :has_zip_code?
  validates :birth_month, :birth_day, presence: { if: :birthday_provided? }
  validates :birth_month, inclusion: { in: ::Date::MONTHNAMES, allow_blank: true }
  validates :birth_day, inclusion: { in: 1..31, allow_blank: true }
  validate :check_date_for_realness
  # Removing username update validation - should check later for conflicts or issues arising from this
  # validate :prevent_username_change, on: :update

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    email = conditions.delete(:email)
    where(conditions).where(["lower(email) = :value OR lower(username) = :value", { :value => email.strip.downcase }]).first
  end
  
  def was_invited?
    self.invitation_sent_at
  end
  
  def just_invited?
    self.invitation_sent_at.to_date == Date.today
  end
  
  def has_zip_code?
    if self.zip_code.nil?
      return false
    else
      return true
    end
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
  
  def gone_for_a_week?
   if (DateTime.now.to_i - self.last_sign_in_at.to_i) / (24 * 60 * 60) > 7
     true
   else
     false
   end
  end
  
  def recent_activity
    @activities = []
   
    venue_scores.each do |a|
      @activities << a
    end
    tips.each do |t|
      @activities << t
    end
    lists.each do |l|
      @activities << l
    end
    # Define later how to make follows display in activity stream
    #follows.each do |f|
    #  @activities << f
    #end
    @activities = @activities.first(10)
    @activities.sort_by {|a| a[:created_at]} #reverse
  end
  
  def network_activity
    @activities = []
    @follows = self.follows.all
   
    @follows.each do |f|
      f.venue_scores.each do |a|
        if (DateTime.now.to_i / (24 * 60 * 60)) - (a.created_at.to_i / (24 * 60 * 60)) <= 30
          @activities << a
        end
      end
      f.tips.each do |t|
        if (DateTime.now.to_i / (24 * 60 * 60)) - (t.created_at.to_i / (24 * 60 * 60)) <= 30
          @activities << t
        end
      end
      f.lists.each do |l|
        if (DateTime.now.to_i / (24 * 60 * 60)) - (l.created_at.to_i / (24 * 60 * 60)) <= 30
          @activities << l
        end
      end

    end
    @activities.sort_by{|a| a[:created_at]}.reverse
  end
  
  def average_score
    @scores = venue_scores.all
    @average_score = 0
    @scores.each do |s|
      @average_score = @average_score + s.computed_score
    end
    if @average_score != 0
      @average_score = @average_score / @scores.count
    else
      @average_score = "No scores yet"
    end
  end
  
  def highest_score
    @scores = venue_scores.all
    if !@scores.empty?
      @scores.sort_by {|score| score.computed_score}.last.computed_score
    else
      "No scores yet"
      
    end 
  end
  
  def highest_score_venue
    @scores = venue_scores.all
    if !@scores.empty?
      @scores.sort_by {|score| score.computed_score}.last.venue
    else
      nil
    end
  end
  
  def lowest_score
    @scores = venue_scores.all
    if !@scores.empty?
      @scores.sort_by {|score| score.computed_score}.first.computed_score
    else
      "No scores yet"
    end
  end
  
  def lowest_score_venue
    @scores = venue_scores.all
    if !@scores.empty?
      @scores.sort_by {|score| score.computed_score}.first.venue
    else
      nil
    end
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
  
  # Creates a URL to user's twitter profile based on the twitter_username field
  def twitter_link
    "http://twitter.com/#{self.twitter_username}"
  end

  # NEED TO CHANGE THIS BACK TO FRIENDLY URLS AFTER FOLLOWING
  def to_param
    "#{username}"
    #"#{id}"
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
  
  def scored_venues
    @scored_venues = []
    self.venue_scores.each do |vs|
      @scored_venues << vs.venue
    end
  end
  
  # Moving permalink method to public to address method error during invitation acceptance
  def create_permalink
    unless username.nil?
      self.permalink = username.downcase
    end
  end

  private

  def downcase_username
    self.username = self.username.downcase
  end
  
  # Create permalink using provided username for user-friendly URLs
  #
  #def create_permalink
  # unless username.nil?
  #    self.permalink = username.downcase
  #  end
  #end
  
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
        #user.username = data["username"]
        user.gender = data["gender"].capitalize
        user.facebook_id = data["id"]
        user.skip_confirmation!
      end
    end
  end
end