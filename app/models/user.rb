class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :birth_month, :birth_day,
                  :password, :password_confirmation, :remember_me

  validates :first_name, presence: true
  validates :birth_month, :birth_day, presence: { if: :birthday_provided? }
  validates :birth_month, inclusion: { in: ::Date::MONTHNAMES, allow_blank: true }
  validates :birth_day, inclusion: { in: 1..31, allow_blank: true }
  validate :check_date_for_realness

  private

  def birthday_provided?
    birth_month? || birth_day?
  end

  def check_date_for_realness
    # test against a leap year so we allow for Feb 29
    Date.new(2008, ::Date::MONTHNAMES.index(birth_month), birth_day) if birth_month? && birth_day?
  rescue
    errors.add(:birthday, "should be a real day of the year.")
  end
end
