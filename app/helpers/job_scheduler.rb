module JobScheduler
include VenueImportsHelper
  
  class FacebookListCreation < Struct.new(:list_url, :facebook_access_token)
    def perform
      @app = FbGraph::Application.new(ENV['FACEBOOK_APP_ID'], :secret => ENV['FACEBOOK_APP_SECRET'])
      @fb_user = FbGraph::User.me(facebook_access_token)
      
      action = @fb_user.og_action!(
               @app.og_action(:create), :list => list_url)
    end
  end
  
  class PublishFBListCreation < Struct.new(:full_list_url, :facebook_access_token)
    def perform
      @app = FbGraph::Application.new(ENV['FACEBOOK_APP_ID'], :secret => ENV['FACEBOOK_APP_SECRET'])
      @fb_user = FbGraph::User.me(facebook_access_token)
      
      puts "Attempting to publish action..."
      action = @fb_user.og_action!(
               @app.og_action(:create), :list => full_list_url)
      if action
        puts "Action should be published..."
      else
        puts "Action was not published..."
      end
    end
  end
  
  class ProcessVenueImportData < Struct.new(:venue_import_id)
    def perform
      Delayed::Worker.logger.debug "--> Looking up venue import object..."
      @import_target = VenueImport.find(venue_import_id)
      Rails.logger.debug "--> Parsing CSV contents..."
      @to_process = CSV.parse(@import_target.content, row_sep: "\n", headers: true)
      
      @to_process.each do |row|
        if Venue.exists?(Venue.find_by_factual_id(row['factual_id']))
          #@existing_venues += 1 
          #@to_process.delete(row)
          Delayed::Worker.logger.debug "--> Existing venue found matching Factual ID"
          venue = update_venue_from_csv(row)
          Delayed::Worker.logger.debug "--> Attempting to update existing venue with id #{venue.id}"
          if venue.changed?
            venue.save!
            Delayed::Worker.logger.debug "--> Existing venue #{venue.id} was updated"
            #@updated_venues << venue
          else
            #@existing_venues += 1
          end
        else
          Delayed::Worker.logger.debug "--> Attempting to create new venue from row"
          venue = create_venue_from_csv(row)
          Delayed::Worker.logger.debug "--> New venue was created with id #{venue.id}"
          if venue.new_record?
            #@unsaved_venues << venue
        else
         #@saved_venues << venue
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
      Rails.logger.debug "--> Content was parsed and handled."
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
    
    tel = !row['tel'].nil? ? row['tel'].gsub(/[^0-9a-z]/i, '') : nil
    
    if row['hours']
      raw_hours = row['hours']
      #raw_hours_string = '#{raw_hours}'
      hours = JSON.parse(raw_hours)
    end
    
    hour_ranges = parse_hour_ranges(hours)
    hours_with_names = parse_hours_with_names(hours)
    
    venue = Venue.create({
	  factual_id: row['factual_id'],
	  factual_category_id: factual_category_id,
	  name: row['name'],
	  address1: row['address'],
	  city: row['locality'],
	  state: row['region'],
	  zip: row['postcode'],
	  country: row['country'],
	  phone: tel,
	  url: row['website'],
	  latitude: row['latitude'],
	  longitude: row['longitude'],
	  neighborhoods: row['neighborhood'],
	  venue_category: category,
	  venue_subcategory: subcategory,
	  hours: hours,
	  hour_ranges: hour_ranges,
	  hours_with_names: hours_with_names
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
    
    tel = !row['tel'].nil? ? row['tel'].gsub(/[^0-9a-z]/i, '') : nil
    
    venue.assign_attributes(
	  name: row['name'],
	  address1: row['address'],
	  city: row['locality'],
	  state: row['region'],
	  zip: row['postcode'],
	  country: row['country'],
	  phone: tel,
	  url: row['website'],
	  latitude: row['latitude'],
	  longitude: row['longitude'],
    )
    
    return venue
  end

  def sanitize_url(url)
    url =~ /^http/ ? url : "http://#{url}"
  end
  
  def parse_hour_ranges(full_hours)
    unless full_hours.nil?
      hour_ranges = {}
      full_hours.each do |day_name, hours|
        hour_range = []
        hours.each do |hour_set|
          hour_range << hour_set[0]
          hour_range << hour_set[1]
          hour_range = hour_range.sort { |x,y| x.to_i <=> y.to_i }
          hour_ranges[:"#{day_name}"] = { :open => hour_range.first, :close => hour_range.last }
        end
      end
    end
    return hour_ranges
  end
  
  def parse_hours_with_names(full_hours)
    unless full_hours.nil?
      hours_with_names = {}
      full_hours.each do |day_name, hours|
        hours_with_names[:"#{day_name}"] = []
        hours.each do |hour_set|
          if hour_set[2]
            hours_with_names[:"#{day_name}"] << { :open => hour_set[0], :close => hour_set[1], :name => hour_set[2] }
          else
            hours_with_names[:"#{day_name}"] << { :open => hour_set[0], :close => hour_set[1], :name => nil }
          end
        end
      end
    end
    return hours_with_names
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

  
  end
  
  

end

