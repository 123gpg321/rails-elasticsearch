class Model < ActiveRecord::Base
  include ElasticsearchModelExtension

  ElasticsearchModelExtension.search("term", 3, 1, 20)
end