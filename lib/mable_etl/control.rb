require 'pry'
require 'extractors/local_extractor'
require 'extractors/S3_extractor'
require 'extractors/extractor_factory'

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
      extract

      transform

      File.delete(params[:mable_etl_file_path]) unless load.nil?

      'success'
    end

    def extract
      mable_etl_file_path = MableEtl::Extractors::ExtractorFactory.for(params).extract
      @params = params.merge({ mable_etl_file_path: mable_etl_file_path })
    end

    def transform
      @params[:transformer_types].each do |transformer_type|
        @params = params.merge({ transformer_type: transformer_type })
        mable_etl_data = MableEtl::Transformers::TransformerFactory.for(params).transform
        @params = params.merge({ mable_etl_data: mable_etl_data })
      end
    end

    def load
      @load ||= MableEtl::Loaders::LoaderFactory.for(params).load
    end
  end
end
