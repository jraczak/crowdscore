class Venue < ActiveRecord::Base
  acts_as_audited protected: false
  acts_as_gmappable :process_geocoding => false

  scope :active, where(active: true)
  scope :alphabetical, order(:name)
  scope :matching, ->(q) { venues = Venue.arel_table; where(venues[:name].matches("%#{q}%")) }

  belongs_to :venue_category
  belongs_to :venue_subcategory

  has_many :venue_scores
  has_many :tips
  has_many :venue_images

  has_and_belongs_to_many :lists
  has_and_belongs_to_many :tags, uniq: true, after_add: :reindex_tags, after_remove: :reindex_tags

  default_accessible_fields = [:name, :address1, :address2, :city, :state, :zip, :phone,
                               :url, :venue_category_id, :venue_subcategory_id,
                               :venue_category, :venue_subcategory, :latitude,
                               :longitude]
  noneditable_fields = [:name, :venue_category_id, :venue_category]

  admin_only_fields = [:active]

  attr_accessible *default_accessible_fields
  attr_accessible *(default_accessible_fields - noneditable_fields), as: :regular_user_editing
  attr_accessible *(default_accessible_fields + admin_only_fields), as: :admin

  validates :name, :address1, :city, :state, :zip, :venue_category, presence: true
  validates :url, format: { with: /^https?:\/\//, allow_blank: true, message: "URL must contain 'http://'" }

  geocoded_by :full_address
  after_validation :geocode, if: :address_parts_changed?

  searchable(include: [:tips, :venue_category, :venue_subcategory, {:tags => :tag_category}]) do
    text :name
    text(:name_without_punc) { |venue| venue.name.gsub(/[^\s\w]/, '') }
    text(:category) { |venue| venue.full_category_name }
    text(:tips) { |venue| venue.tips.map(&:text) }
    text(:tags) { |venue| venue.tags.map(&:full_name) }

    latlon(:location) { Sunspot::Util::Coordinates.new(latitude, longitude) }
  end
  
  def self.higher_scored_than(venue, _limit = 10)
    # Original implementation below and not scoped to location. Trying new implementation.
    #where('computed_score > ?', venue.computed_score.to_i).limit _limit
    Venue.near([venue.latitude, venue.longitude], 2).where('computed_score > ?', venue.computed_score.to_i).limit _limit
  end

  def to_param
    slug = "#{id}-"
    slug += "#{name} #{city} #{state}".downcase.gsub(/[^\w\s]/, '').gsub(/\s+/, '-')
  end

  def full_category_name
    full_name = venue_category.name
    full_name += " | #{venue_subcategory.name}" if venue_subcategory.present?
    full_name
  end

  def score
    computed_score? ? computed_score : "No score yet"
  end

  def score_breakdown1
    scores = venue_scores.map { |s| s.score1.to_f }
    ((scores.inject(&:+) / scores.length) * 10).ceil
  rescue
    "N/A"
  end

  def score_breakdown2
    scores = venue_scores.map { |s| s.score2.to_f }
    ((scores.inject(&:+) / scores.length) * 10).ceil
  rescue
    "N/A"
  end

  def score_breakdown3
    scores = venue_scores.map { |s| s.score3.to_f }
    ((scores.inject(&:+) / scores.length) * 10).ceil
  rescue
    "N/A"
  end

  def score_breakdown4
    scores = venue_scores.map { |s| s.score4.to_f }
    ((scores.inject(&:+) / scores.length) * 10).ceil
  rescue
    "N/A"
  end

  def recompute_score!
    scores = venue_scores.map { |s| s.computed_score.to_f }
    self.computed_score = (scores.inject(&:+) / scores.length).ceil
    save!
  end

  def full_address
    [address1, address2, city, state, zip].compact.join(", ")
  end

  def self.update_missing_geocodes
    where('longitude IS NULL OR latitude IS NULL').each do |venue|
      venue.update_geocode
    end
  end

  def update_geocode
    geocode && save!
  end
  
  def gmaps4rails_address
    "#{self.address1}, #{self.city}, #{self.state}, #{self.zip}"
  end
  
  def gmaps4rails_infowindow
    "#{self.score} <br> #{self.name} <br> #{self.full_category_name}"
  end
  
  def recent_tip
    self.tips.first
  end

  private

  def address_parts_changed?
    address1_changed? || address2_changed? || city_changed? || state_changed? || zip_changed?
  end

  def reindex_tags(tag)
    index!
  end
  
  
end
