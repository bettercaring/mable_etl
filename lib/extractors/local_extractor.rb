# frozen_string_literal: true

require 'pry'
require 'csv'
require 'mable_etl/errors/extractors/local_extractor'
require_relative '../contracts/local_extractor_contract'
require_relative '../helpers/validation'

module MableEtl
  class Extractors
    class LocalExtractor
      prepend Validation
      attr_accessor :params

      validation_options contract_klass: MableEtl::Contracts::LocalExtractorContract,
                         error_klass: MableEtl::Errors::Extractors::LocalExtractor
      def initialize(params)
        @file_path = params[:file_path]
      end

      def extract
        FileUtils.cp(@file_path, 'temp/')
      end
    end
  end
end
