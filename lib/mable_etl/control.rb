require 'pry'
require 'extractors/local_extractor'
require 'extractors/S3_extractor'
require 'extractors/extractor_factory'
# require 'mable_etl/errors/configuration'

# send hash to controller, hash contains extractor_type (as well as params for file location and credentials if S3),
# transformer_type in an array(also data from extractor),
# loader_type(also data from transformer to be saved in new location)

module MableEtl
  class Control
    attr_accessor :params

    def initialize(params)
      @params = params
    end

    def process
      # get source, figure out transformers from client and then loader
      # all of these are from config
      # transformer has an array of items one after the other
      extractor

      transformer

      binding.pry
      File.delete(params[:mable_etl_file_path]) if loader.persisted?

      # delete file if loader is successful
    end

    def extractor
      mable_etl_file_path = MableEtl::Extractors::ExtractorFactory.for(params).extract
      @params = params.merge({ mable_etl_file_path: mable_etl_file_path })
    end

    def transformer
      @params[:transformer_types].each do |transformer_type|
        @params = params.merge({ transformer_type: transformer_type })
        mable_etl_data = MableEtl::Transformers::TransformerFactory.for(params).transform
        @params = params.merge({ mable_etl_data: mable_etl_data })
      end
    end

    def loader
      @loader ||= MableEtl::Loaders::LoaderFactory.for(params).load
    end
  end
end
