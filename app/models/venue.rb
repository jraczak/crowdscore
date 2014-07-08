class Venue < ActiveRecord::Base
  acts_as_audited protected: false
  acts_as_gmappable :process_geocoding => false
  acts_as_mappable :default_units => :miles,
  		           :lat_column_name => :latitude,
  		           :lng_column_name => :longitude#,
  		           #:auto_geocode => true

  scope :active, where(active: true)
  scope :alphabetical, order(:name)
  scope :matching, ->(q) { venues = Venue.arel_table; where(venues[:name].matches("%#{q}%")) }

  belongs_to :venue_category
  belongs_to :venue_subcategory

  has_many :venue_scores, dependent: :destroy
  has_many :tips, dependent: :destroy
  has_many :venue_images
  has_many :venue_snapshots
  has_many :scores, dependent: :destroy

  has_and_belongs_to_many :lists
  has_and_belongs_to_many :tags, uniq: true, after_add: :reindex_tags, after_remove: :reindex_tags

  default_accessible_fields = [:name, :address1, :address2, :city, :state, :zip, :phone,
                               :url, :venue_category_id, :venue_subcategory_id,
                               :venue_category, :venue_subcategory, :latitude,
                               :longitude, :factual_id, :country, :factual_category_id, :neighborhoods, :hours, :hour_ranges, :hours_with_names]
  noneditable_fields = [:name, :venue_category_id, :venue_category]

  admin_only_fields = [:active]

  attr_accessible *default_accessible_fields
  attr_accessible *(default_accessible_fields - noneditable_fields), as: :regular_user_editing
  attr_accessible *(default_accessible_fields + admin_only_fields), as: :admin
  
  store :hours
  store :hour_ranges
  store :hours_with_names

  validates :name, :address1, :city, :state, :zip, :venue_category, presence: true
  validates :url, format: { with: /^https?:\/\//, allow_blank: true, message: "URL must contain 'http://'" }
  validates :factual_id, uniqueness: true

  geocoded_by :full_address
  
  ##Remove geocoding for now as latlong is received from Factual
  ##and these calls to the API are unnecessary
  #after_validation :geocode, if: :address_parts_changed?

  searchable(include: [:tips, :venue_category, :venue_subcategory]) do
    text :name
    text(:name_without_punc) { |venue| venue.name.gsub(/[^\s\w]/, '') }
    text(:category) { |venue| venue.full_category_name }
    text(:tips) { |venue| venue.tips.map(&:text) }
    #text(:tags) { |venue| venue.tags.map(&:full_name) }
    integer :venue_category_id, :multiple => true
    integer :venue_subcategory_id, :multiple => true

    latlon(:location) { Sunspot::Util::Coordinates.new(latitude, longitude) }
  end
  
  def self.higher_scored_than(venue, _limit = 4)
    # Original implementation below and not scoped to location. Trying new implementation.
    #where('computed_score > ?', venue.computed_score.to_i).limit _limit
    Venue.near([venue.latitude, venue.longitude], 2).where('computed_score > ? AND venue_category_id = ?', venue.computed_score.to_i, venue.venue_category_id).limit _limit
  end
  
  def to_param
    slug = "#{id}-"
    slug += "#{name} #{city} #{state}".downcase.gsub(/[^\w\s]/, '').gsub(/\s+/, '-')
  end

  def full_category_name separator='|'
    full_name = venue_category.name
    full_name += " #{separator} #{venue_subcategory.name}" if venue_subcategory.present?
    full_name.html_safe
  end

  def score
    computed_score? ? computed_score : 0
  end

  def graph_score
    computed_score? ? computed_score : Random.rand(100)
  end
  
  #TO-DO: DETERMINE IF THIS IS NECESSARY OR CAN BE CALCULATED FROM THE OBJECTS
  def score_category_count
    if self.venue_subcategory.score_categories.any?
      self.venue_subcategory.score_categories.count
    else
      self.venue_category.score_categories.count
    end
  end
  
  def get_score_categories
    @score_categories = []
    if venue_subcategory && venue_subcategory.score_categories.any?
      venue_subcategory.score_categories.each do |sc|
        @score_categories << sc
      end
    else
      venue_category.score_categories.each do |sc|
        @score_categories << sc
      end
    end
  end
  
  def score_details
    categories = get_score_categories
    score_buckets = {}
    calculated_scores = {}
    all_scores = []
    
    categories.each do |c|
      calculated_scores[c.id] = {:id => c.id, :name => c.name, :value => 0}
    end
    
    self.venue_scores.each do |vs|
      vs.scores.each do |s|
        all_scores << s
      end
    end
    
    all_scores.each do |score|
      if !score_buckets[score.score_category_id].present?
        score_buckets[score.score_category.id] = []
      end
      score_buckets[score.score_category_id] << score.value
    end

    score_buckets.each do |key, array|
      averaged_scores = score_buckets[key].reduce(:+) / score_buckets[key].length
      calculated_scores[key][:value] = averaged_scores
    end
    
    return calculated_scores
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
    scores = venue_scores.map(&:computed_score)
    self.computed_score = (scores.inject(&:+) / scores.length).ceil
    save!
  end
  
  # OLD RECOMPUTE METHOD, DEPRECATED WITH NO SCORE STRUCTURES
  #def recompute_score!
  #  scores = venue_scores.map { |s| s.computed_score.to_f }
  #  self.computed_score = (scores.inject(&:+) / scores.length).ceil
  #  save!
  #end

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
    percent = self.graph_score
    str = ""
    str += "<div class='cs-iw'>"
    str += '<div class="cs-iw-p-m"><div class="cs-iw-pt"><div></div></div><div class="cs-iw-pb"><div class=""></div></div></div>'
    str += "<div class='pie-container map'>"
    str +="<div class='pie-graph-loader' data-percent=#{percent} data-venue-id='#{self.id}'>"
    str +="<div class='pie-graph-masks'></div>"
    str +="<span class='pie-graph-left-block'></span>"
    str +="<span class='pie-graph-right-block'></span>"
    str +="<div class='pie-graph-mask-color-white'>#{percent}</div>"
    str +="</div>"
    str +="</div>"
    str +="<a class='venue-name' href='/venues/#{self.id}'>#{self.name}</a>"
    str += "<div class='cs-iw-cid'>"
    str += "<span class='category'>#{self.venue_subcategory}</span>"
    str += "<span class='distance'>0.1 mi away</span>"
    str += "</div>"
    str += "</div>"
    str.html_safe
    #{}"#{self.score} <br> #{self.name} <br> #{self.full_category_name('<span></span>')}"
  end
  
  ## Gets the most recent tip to be used in tooltips and summaries around the application.
  def recent_tip
    self.tips.first
  end
  
  ## A helper that returns relevant hash tags based on the venue category to be used in Twitter shares
  def hash_tags(venue_category)
    hashtags = []
    hash_tag_string = ""
    if venue_category.name == "Restaurant"
      hashtags << "#restaurants"
    elsif venue_category.name == "Salons & Spas"
      hashtags << ["#salons", "#spas"]
    elsif venue_category.name == "Hotels & Resorts"
      hashtags << ["#hotels", "#resorts"]
    elsif venue_category.name == "Bars & Nightlife"
      hashtags << ["#bars", "#nightlife"]
    end
    hashtags.each do |h|
      hash_tag_string << "#{h} "
    end
  end

  private

  def address_parts_changed?
    address1_changed? || address2_changed? || city_changed? || state_changed? || zip_changed?
  end

  def reindex_tags(tag)
    index!
  end
  
  
end
