require 'active_support/concern'

module ElasticsearchVenue

  extend ActiveSupport::Concern
  
  included do
    require 'elasticsearch/model'
    include Elasticsearch::Model
    include Elasticsearch::Model::Indexing
    include Elasticsearch::Model::Callbacks
    
    #mapping do
    #  #write some code
    #end
    
    
    #module ClassMethods
      
      def self.search(query, location, search_type, search_radius="5mi")
        # TO-DO: Figure out how to prevent geocoding the location param during every iteration
        search_location = Geokit::Geocoders::GoogleGeocoder.geocode(location)
        
        case search_type
        when "similar nearby"
          __elasticsearch__.search(
            {
    	          query: {
	      	        nested: {
		      	        path: "properties",
		      	        query: {match: {cuisines: query}}
	      	        }
    	          },
                filter: {
    	              geo_distance: {
    	  	            distance: "2mi",
    	  	            location: {
    	  		            lon: search_location.lng,
    	  		            lat: search_location.lat
    	  	            }
    	  	            
    	              }
                }
            }
          )
        when "standard search"
          __elasticsearch__.search(
            {
    	          query: {
	      	        multi_match: {
    	  		        query: query,
    	  		        type: 'most_fields',
    	  		        # TO DO: GET THIS INTO USING DYNAMIC FIELDS FROM PARAMS
    	  		        fields: ['name^3', 'properties.cuisines^2', 'tips.text^1', 'venue_subcategory.name'],
    	  		        #fields: search_fields,
    	  		        minimum_should_match: '50%'
    	  	        }
    	          },
                filter: {
    	              geo_distance: {
    	  	            distance: search_radius,
    	  	            location: {
    	  		            lon: search_location.lng,
    	  		            lat: search_location.lat
    	  	            }
    	  	            
    	              }
                }
            }
          )
        when "cuisine search"
          __elasticsearch__.search(
            {
    	          query: {
	      	        nested: {
		      	        path: "properties",
		      	        query: {match: {cuisines: query}}
	      	        }
    	          },
                filter: {
    	              geo_distance: {
    	  	            distance: search_radius,
    	  	            location: {
    	  		            lon: search_location.lng,
    	  		            lat: search_location.lat
    	  	            }
    	  	            
    	              }
                }
            }
          )
        # this is the end for the case statement
        end
      # this is the end for the search definition
      end
    
    
    def self.dashboard_cuisine_search(cuisine, location)
      search_location = location
      __elasticsearch__.search(
        {
    	        query: {
    		        multi_match: {
    			        query: cuisine,
    			        type: 'most_fields',
    			        fields: ['properties.cuisines']
    			        
    		        }
    	        },
              filter: {
    	            geo_distance: {
    		            distance: "5mi",
    		            location: {
    			            lon: search_location["lng"],
    			            lat: search_location["lat"]
    		            }
    		            
    	            }
              }
          }
      )
    end
  end
  

end