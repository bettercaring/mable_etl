# frozen_string_literal: true

require 'pry'
require 'csv'
require_relative '../contracts/csv_object_transformer_contract'

module MableEtl
  class Transformers
    class CsvObjectTransformer
      def initialize(params)
        @params = params

        validation

        @file_path = params[:file_path]
      end

      def transform
        ::CSV.parse(File.read(@file_path), headers: true)
      end

      attr_reader :params, :contract_result

      def validation
        contract_result = MableEtl::Contracts::CsvObjectTransformerContract.new.call(params)

        return if contract_result.success?

        raise MableEtl::Errors::Transformers::CsvObjectTransformer, contract_result.errors.to_h.to_s
      end
    end
  end
end