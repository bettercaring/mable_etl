# frozen_string_literal: true

require 'pry'
require 'csv'
require 'mable_etl/errors/extractors/local_extractor'
require_relative '../contracts/local_extractor_contract'

module MableEtl
  class Extractors
    class LocalExtractor
      def initialize(params)
        @params = params

        validation

        @file_path = params[:file_path]
      end

      def extract
        FileUtils.cp(@file_path, 'temp/')
      end

      private

      attr_reader :params, :contract_result

      def validation
        contract_result = MableEtl::Contracts::LocalExtractorContract.new.call(params)

        return if contract_result.success?

        raise MableEtl::Errors::Extractors::LocalExtractor, contract_result.errors.to_h.to_s
      end
    end
  end
end