require 'active_support/concern'

module ElasticsearchVenue

  extend ActiveSupport::Concern
  
  included do
    require 'elasticsearch/model'
    include Elasticsearch::Model
    include Elasticsearch::Model::Indexing
    
    #mapping do
    #  #write some code
    #end
    
    #def self.search(query)
    #  super
    #end
  end

end