# encoding: UTF-8

require 'csv'

class VenueImport
  include ActiveModel::Validations
  extend ActiveModel::Naming 
  include ActiveModel::Conversion

  attr_reader :file, :saved_venues, :unsaved_venues

  def initialize(options)
    @file = options[:file]
  end

  def valid?
    errors.empty?
  end

  def persisted?
    false
  end

  def save
    cleanup_before_save

    @to_process = CSV.parse(file.tempfile, row_sep: "\n", headers: true)
    process_files!
  rescue ArgumentError, CSV::MalformedCSVError => e
    errors.add :csv_file, "is not valid"
  end

  def report
    message = "#{saved_venues.length} venue(s) were successfully imported."
    message += " #{unsaved_venues.length} venue(s) could not be imported." if unsaved_venues.any?
    message
  end

  private

  def cleanup_before_save
    errors.clear
    @saved_venues = []
    @unsaved_venues = []
  end

  def process_files!
    @to_process.each do |row|
      venue = create_venue_from_csv(row)

      if venue.new_record?
        @unsaved_venues << venue
      else
        @saved_venues << venue
      end
    end
  end

  def create_venue_from_csv(row)
    category = find_category(row['Category'])
    subcategory = find_subcategory(category, row['Subcategory'])

    venue = Venue.create({
      name: row['Name'],
      address1: row['Address 1'],
      address2: row['Address 2'],
      city: row['City'],
      state: row['State'],
      zip: row['Zip'],
      phone: row['Phone'],
      url: sanitize_url(row['URL']),
      venue_category: category,
      venue_subcategory: subcategory
    })
  end

  def find_category(name)
    VenueCategory.find_by_name(name)
  end

  def find_subcategory(category, name)
    VenueSubcategory.find_by_name_and_venue_category_id(name, category.try(:id))
  end

  def sanitize_url(url)
    url =~ /^http/ ? url : "http://#{url}"
  end
end
