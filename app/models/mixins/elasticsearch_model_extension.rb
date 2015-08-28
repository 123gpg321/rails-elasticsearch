module ElasticsearchModelExtension
  include Elasticsearch::Model
  require 'elasticsearch/model'

  settings(ElasticsearchAnalyzers.example_name_analyzer.settings) do
    mappings dynamic: 'false' do
      indexes :product_name, analyzer: "example_name_analyzer"
      indexes :venue_id
    end
  end

  def self.search(query, venue_id, page, per_page)
    @page = page.to_i > 1 ? ((page.to_i-1)*per_page.to_i) : 0
    @per_page = (per_page.to_i||20)
    __elasticsearch__.search(
        {query:
             {bool:
                  {must: [
                      {query_string: {default_field: "index_name.type_name", query: query}},
                      {term: {venue_id: venue_id}}
                  ],
                   must_not: [],
                   should: []}},
         from: @page,
         size: @per_page,
         sort: [],
         facets: {}
        }
    )
  end

end

