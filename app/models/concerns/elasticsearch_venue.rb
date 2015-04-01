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
    
    def self.search(query)
      __elasticsearch__.search(
        {
	        query: {
		        multi_match: {
			        query: query,
			        type: 'most_fields',
			        fields: ['name^2', 'properties.cuisines^1', 'tips.text^2', 'venue_subcategory.name'],
			        
		        }
	        }
        }
      )
    end
  end

end