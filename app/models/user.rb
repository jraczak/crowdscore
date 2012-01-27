class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  # and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  default_accessible_fields = [:email, :first_name, :last_name, :birth_month,
                               :birth_day, :password, :password_confirmation,
                               :remember_me, :username, :zip_code, :gender]
  admin_only_fields = [:admin]

  attr_accessible *default_accessible_fields
  attr_accessible *(default_accessible_fields + admin_only_fields), :as => :admin

  has_many :tip_likes, dependent: :destroy
  has_many :liked_tips, through: :tip_likes, source: :tip

  validates :first_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :zip_code, presence: true, numericality: true, length: { is: 5 }
  validates :birth_month, :birth_day, presence: { if: :birthday_provided? }
  validates :birth_month, inclusion: { in: ::Date::MONTHNAMES, allow_blank: true }
  validates :birth_day, inclusion: { in: 1..31, allow_blank: true }
  validate :check_date_for_realness
  validate :prevent_username_change, on: :update

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

  def unlock_access!
    self.lock_reason = nil
    super
  end

  # TODO: TEST THIS!
  def has_scored_venue?(venue)
    VenueScore.exists?(user_id: id, venue_id: venue)
  end

  private

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
end
