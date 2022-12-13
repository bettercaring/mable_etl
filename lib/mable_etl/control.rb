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
      @logger = params[:logger]
    end

    def process
      result = extract
      return result unless result.success?

      result = transform
      return result unless result.success?

      File.delete(params[:mable_etl_file_path]) unless load.nil?

      load
    end

    private

    attr_reader :logger

    def extract
      result = MableEtl::Extractors::ExtractorFactory.for(params).extract

      @params = params.merge({ mable_etl_file_path: result.mable_etl_file_path })

      log_result(result)
    end

    def transform
      @params[:transformer_types].each do |transformer_type|
        @params = params.merge({ transformer_type: transformer_type })
        @result = MableEtl::Transformers::TransformerFactory.for(params).transform

        log_result(@result)

        break unless @result.success?

        @params = params.merge({ mable_etl_data: @result.mable_etl_data })
      end

      @result
    end

    def load
      @load ||= MableEtl::Loaders::LoaderFactory.for(params).load
    end

    def log_result(result)
      if result.success?
        logger.info(result.message)
      else
        logger.error(result.message)
      end
      result
    end
  end
end
