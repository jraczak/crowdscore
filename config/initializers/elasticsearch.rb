require 'elasticsearch/model'

if ENV['FOUNDELASTICSEARCH_URL']
  Elasticsearch::Model.client = Elasticsearch::Client.new({url: ENV['FOUNDELASTICSEARCH_URL'], logs: true}
end