# frozen_string_literal: true

require 'pry'
require 'mable_etl/errors/extractors/extractor_factory'
require 'extractors/local_extractor'

# ExtractorFactory.for(params).load
# The object contains the class, data and config for loader

module MableEtl
  class Extractors
    class ExtractorFactory
      def self.for(params)
        raise MableEtl::Errors::Extractors::ExtractorFactory, 'extractor_type is missing' if params[:extractor_type].nil?

        class_eval("MableEtl::Extractors::#{params[:extractor_type]}", __FILE__, __LINE__).new(params).extract
      end
    end
  end
end