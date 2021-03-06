require 'active_support/concern'
require 'elasticsearch/model'

module ElasticsearchUser

  extend ActiveSupport::Concern
  
  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Indexing
    
    #mapping do
    #  #to-do
    #end
    
    def self.search(query)
      __elasticsearch__.search(
        {
	        query: {
		        multi_match: {
			        query: query,
			        fields: ['username^2', 'email', 'full_name']
		        }
	        }
        }
      )
    end
  
  end
end