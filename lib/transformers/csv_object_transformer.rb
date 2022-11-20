# frozen_string_literal: true

require 'pry'
require 'csv'
require_relative '../contracts/csv_object_transformer_contract'
require_relative '../helpers/validation'
require 'mable_etl/errors/transformers/csv_object_transformer'
require_relative './transformer_result'

module MableEtl
  class Transformers
    class CsvObjectTransformer
      prepend Validation
      attr_accessor :params

      validation_options contract_klass: MableEtl::Contracts::CsvObjectTransformerContract,
                         error_klass: MableEtl::Errors::Transformers::CsvObjectTransformer

      def initialize(params)
        @file_path = params[:mable_etl_file_path]
      end

      def transform
        # in future write code for files with no headers
        result = ::CSV.parse(File.read(@file_path), headers: true)

        TransformerResult.new(message: "Transformer success: #{@file_path} transformed to CSV object",
                              mable_etl_data: result)
      end
    end
  end
end
