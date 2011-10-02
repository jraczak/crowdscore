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
    errors.clear
    @saved_venues = []
    @unsaved_venues = []
    CSV.parse(file.tempfile, row_sep: "\n", headers: true) do |row|
      url = row['URL']
      url = "http://#{url}" if url !~ /^http/
      category = VenueCategory.find_by_name(row['Category'])

      venue = Venue.create({
        name: row['Name'],
        address1: row['Address 1'],
        address2: row['Address 2'],
        city: row['City'],
        state: row['State'],
        zip: row['Zip'],
        phone: row['Phone'],
        url: url,
        venue_category: category,
        venue_subcategory: VenueSubcategory.find_by_name_and_venue_category_id(row['Subcategory'], category.try(:id))
      })

      if venue.new_record?
        @unsaved_venues << venue
      else
        @saved_venues << venue
      end
    end
  rescue ArgumentError, CSV::MalformedCSVError => e
    errors.add :csv_file, "is not valid"
  end

  def report
    message = "#{saved_venues.length} venue(s) were successfully imported."
    message += " #{unsaved_venues.length} venue(s) could not be imported." if unsaved_venues.any?
    message
  end

end
