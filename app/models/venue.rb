class Venue < ActiveRecord::Base
  default_scope order(:name)
  scope :active, where(active: true)
  scope :matching, ->(q) { venues = Venue.arel_table; where(venues[:name].matches("%#{q}%")) }

  belongs_to :venue_category
  belongs_to :venue_subcategory

  has_many :venue_scores
  has_many :venue_images

  default_accessible_fields = [:name, :address1, :address2, :city, :state, :zip, :phone,
                               :url, :venue_category_id, :venue_subcategory_id, :venue_category, :venue_subcategory]
  admin_only_fields = [:active]

  attr_accessible *default_accessible_fields
  attr_accessible *(default_accessible_fields + admin_only_fields), :as => :admin

  validates :name, :address1, :city, :state, :zip, :venue_category, presence: true
  validates :url, format: { with: /^https?:\/\//, allow_blank: true, message: "URL must contain 'http://'" }

  def full_category_name
    full_name = venue_category.name
    full_name += " - #{venue_subcategory.name}" if venue_subcategory.present?
    full_name
  end

  def score
    computed_score? ? computed_score : "No score yet"
  end

  def recompute_score!
    scores = venue_scores.map { |s| s.computed_score.to_f }
    self.computed_score = (scores.inject(&:+) / scores.length).ceil
    save!
  end
end
