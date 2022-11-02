# frozen_string_literal: true

require 'pry'
require_relative '../contracts/extractor_factory_contract'
require 'mable_etl/errors/extractors/extractor_factory'
require 'extractors/local_extractor'
require 'extractors/S3_extractor'

# ExtractorFactory.for(params).load
# The object contains the class, data and config for loader

module MableEtl
  class Extractors
    class ExtractorFactory
      def self.for(params)
        validations(params)

        class_eval("MableEtl::Extractors::#{params[:extractor_type]}", __FILE__, __LINE__).new(params).extract
      end

      def self.validations(params)
        contract_result = MableEtl::Contracts::ExtractorFactoryContract.new.call(params)

        return if contract_result.success?

        raise MableEtl::Errors::Extractors::ExtractorFactory, contract_result.errors.to_h.to_s
      end
    end
  end
end