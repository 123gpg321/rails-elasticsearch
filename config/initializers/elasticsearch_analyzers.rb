class ElasticsearchAnalyzers
  def self.example_name_analyzer
    new({
      :analysis => {
        :filter => {
          :example_name_ngram => {
            :type => "nGram",
            :min_ngram => 3,
            :max_ngram => 5,
            :token_chars => [
              'letter', 'digit', 'symbol', '&'
            ]
          }
        },
        :analyzer => {
          :example_name_analyzer => {
            :type => :custom,
            :tokenizer => :standard,
            :filter => [
              "standard",
              "lowercase",
              "example_name_ngram"
            ]
          }
        }
      }
    })
  end

  attr_accessor :settings
  def initialize(s)
    @settings = s
  end

end

