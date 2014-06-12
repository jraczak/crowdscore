# encoding: UTF-8

require 'csv'

class VenueImport
  include ActiveModel::Validations
  extend ActiveModel::Naming 
  include ActiveModel::Conversion

  attr_accessor :file, :saved_venues, :unsaved_venues

  #def initialize(attributes = {})
   def initialize(options)
    #attributes.each { |name, value| send("#{name}=", value) }
    
    @file = options[:file]
  end

  def valid?
    errors.empty?
  end

  def persisted?
    false
  end

  def save
    if file.present?
      cleanup_before_save
  
      @to_process = CSV.parse(file.tempfile, row_sep: "\n", headers: true)
      process_files!
    else
      errors.add :csv_file, "can't be blank"
    end
  rescue ArgumentError, CSV::MalformedCSVError => e
    errors.add :csv_file, "is not valid"
  end

  def report
    message = "#{saved_venues.length} venue(s) were successfully imported."
    message += " #{unsaved_venues.length} venue(s) not imported due to failed validations." if unsaved_venues.any?
    message += " #{@existing_venues} unchanged venue(s) were not imported." if @existing_venues > 0
    message += " #{@updated_venues.length} venue(s) updated with new data." if @updated_venues.any?
    message
  end

  private

  def cleanup_before_save
    errors.clear
    @saved_venues = []
    @unsaved_venues = []
    @updated_venues = []
    @existing_venues = 0
  end

  def process_files!
    @to_process.each do |row|
      if Venue.exists?(Venue.find_by_factual_id(row['factual_id']))
        #@existing_venues += 1 
        #@to_process.delete(row)
        venue = update_venue_from_csv(row)
        if venue.changed?
          venue.save!
          @updated_venues << venue
        else
          @existing_venues += 1
        end
      else
        venue = create_venue_from_csv(row)
        if venue.new_record?
        @unsaved_venues << venue
      else
        @saved_venues << venue
      end
    end

      #if !venue.id_changed?
      #  @updated_venues << venue
      #if venue.new_record?
      #  @unsaved_venues << venue
      #else
      #  @saved_venues << venue
      #end
    end
  end

  def create_venue_from_csv(row)
    factual_category_id = row['category_ids'].gsub(/[^0-9a-z]/i, '').to_i
    #category = find_category(factual_category_id)
    #subcategory = find_subcategory(factual_category_id)
    if VenueSubcategory.exists?(:factual_category_id => factual_category_id)
      subcategory = VenueSubcategory.find_by_factual_category_id(factual_category_id)
      category = VenueCategory.find(subcategory.venue_category.id)
    else
      category = VenueCategory.find_by_factual_category_id(factual_category_id)
      subcategory = nil
    end
    venue = Venue.create({
	  factual_id: row['factual_id'],
	  factual_category_id: factual_category_id,
	  name: row['name'],
	  address1: row['address'],
	  city: row['locality'],
	  state: row['region'],
	  zip: row['postcode'],
	  country: row['country'],
	  phone: row['tel'].gsub(/[^0-9a-z]/i, ''),
	  url: row['website'],
	  latitude: row['latitude'],
	  longitude: row['longitude'],
	  venue_category: category,
	  venue_subcategory: subcategory
    })    
    
    #venue = Venue.create({
    #  name: row['Name'],
    #  address1: row['Address 1'],
    #  address2: row['Address 2'],
    #  city: row['City'],
    #  state: row['State'],
    #  zip: row['Zip'],
    #  phone: row['Phone'],
    #  url: sanitize_url(row['URL']),
    #  venue_category: category,
    #  venue_subcategory: subcategory
    #})
  end
  
  def update_venue_from_csv(row)
    venue = Venue.find_by_factual_id(row['factual_id'])
    venue.assign_attributes(
	  name: row['name'],
	  address1: row['address'],
	  city: row['locality'],
	  state: row['region'],
	  zip: row['postcode'],
	  country: row['country'],
	  phone: row['tel'].gsub(/[^0-9a-z]/i, ''),
	  url: row['website'],
	  latitude: row['latitude'],
	  longitude: row['longitude'],
    )
    
    return venue
  end

  def find_category(factual_category_id)
    #VenueCategory.find_by_name(name)
    map = FactualCrowdscoreMap.find_by_factual_category_id(factual_category_id)
    VenueCategory.find(map.venue_category_id)
  end

  def find_subcategory(factual_category_id)
    #VenueSubcategory.find_by_name_and_venue_category_id(name, category.try(:id))
    map = FactualCrowdscoreMap.find_by_factual_category_id(factual_category_id)
    VenueSubcategory.find(map.venue_subcategory_id) unless map.venue_subcategory_id.blank?
  end

  def sanitize_url(url)
    url =~ /^http/ ? url : "http://#{url}"
  end
end
