class ElasticsearchReindex

  class ModelOneReindex
    def self.start
      # Delete the previous ModelOne index in Elasticsearch
      ModelOne.__elasticsearch__.client.indices.delete index: ModelOne.index_name rescue nil

      # Create the new index with the new mapping
      ModelOne.__elasticsearch__.client.indices.create \
              index: ModelOne.index_name,
              body: {settings: ModelOne.settings.to_hash, mappings: ModelOne.mappings.to_hash}

      # Index all ModelOne records from the DB to Elasticsearch
      ModelOne.import
    end
  end

  class ModelTwoReindex
    def self.start
      # Delete the previous ModelTwo index in Elasticsearch
      ModelTwo.__elasticsearch__.client.indices.delete index: ModelTwo.index_name rescue nil

      # Create the new index with the new mapping
      ModelTwo.__elasticsearch__.client.indices.create \
              index: ModelTwo.index_name,
              body: {settings: ModelTwo.settings.to_hash, mappings: ModelTwo.mappings.to_hash}

      # Index all ModelTwo records from the DB to Elasticsearch
      ModelTwo.import
    end
  end

  def self.perform
    ModelOneReindex.start
    ModelOneReindex.start
  end

  self.perform

end