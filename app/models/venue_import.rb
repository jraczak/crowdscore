# encoding: UTF-8

require 'csv'

class VenueImport < ActiveRecord::Base
  #include ActiveModel::Validations
  #extend ActiveModel::Naming 
  #include ActiveModel::Conversion

  attr_accessor :file, :saved_venues, :unsaved_venues
  
  #mount_uploader :venue_import, VenueImportUploader

  #def initialize(attributes = {})
   #def initialize(options)
   # #attributes.each { |name, value| send("#{name}=", value) }
   # 
   # @file = options[:file]
  #end

#   def valid?
#     errors.empty?
#   end

  #def persisted?
  #  false
  #end

  #def save
  #  if file.present?
  #    cleanup_before_save
  #
  #    Rails.logger.debug "--> Trying to read csv file..."
  #    content = File.read(file.tempfile)
  #    Rails.logger.debug "--> Loading csv contents into content column..."
  #    self.content = content
  #    
  #    #@to_process = CSV.parse(file.tempfile, row_sep: "\n", headers: true)
  #    #process_files!(@csv_content.id)
  #  else
  #    errors.add :csv_file, "can't be blank"
  #  end
  #  #rescue ArgumentError, CSV::MalformedCSVError => e
  #  #errors.add :csv_file, "is not valid"
  #end
  #
  
  
end
 
 
#hours.each do |day_name, hours|
#     hour_range = []
#   hours.each do |hour_set|
#       hour_set.each do |hour|
#         hour_range << hour
#       end
#     hour_range = hour_range.sort { |x, y| x.to_i <=> y.to_i }
#     hours_range[:"#{day_name}"] = {:open => hour_range.first, :close => hour_range.last }
#     end
#   end
   
   #Pulling out human readable values from the hash after created from the JSON
   #puts "#{key} we open at #{Time.parse(values[:open]).strftime("%l:%M%p")} and close at #{Time.parse(values[:close]).strft 
