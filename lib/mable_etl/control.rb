require 'pry'
# require 'mable_etl/errors/configuration'

module MableEtl
  class Configuration
    def initialize(params)
      @params = params
    end

    def process
      # get source, figure out transformers from client and then loader
      # all of these are from config
      # transformer has an array of items one after the other
      extractor

      transformer

      loader

      #delete file if loader is successful
    end

    private

    attr_accessor :params

    def extractor
      binding.pry
      mable_etl_file_path = MableEtl::Extractors::ExtractorFactory.for(params).extract
      @params << { mable_etl_file_path: mable_etl_file_path }
    end

    def transformer
      params[transformer_list].each do |transformer| 
      data = MableEtl::Transformers::TransformerFactory.for(params).transformer
      @params << { data: data }
      end
    end

    def loader
      @loader ||= MableEtl::Loaders::LoaderFactory.for(params).loader
    end
  end
end
