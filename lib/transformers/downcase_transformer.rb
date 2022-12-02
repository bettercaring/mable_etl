# frozen_string_literal: true

require 'mable_etl/errors/transformers/downcase_transformer'
require_relative '../contracts/downcase_transformer_contract'
require_relative '../helpers/validation'
require_relative './transformer_result'

module MableEtl
  class Transformers
    class DowncaseTransformer
      prepend Validation
      attr_accessor :params

      validation_options contract_klass: MableEtl::Contracts::DowncaseTranformerContract,
                         error_klass: MableEtl::Errors::Transformers::DowncaseTransformer

      def initialize(params)
        @data = params[:mable_etl_data]
        @downcase_columns = params[:downcase_columns]
      end

      def transform
        result = @data.map do |row|
          downcase_columns.each do |column|
            row_data = row[column]

            next unless row_data.is_a?(String)

            row[column] = row_data.downcase
          end

          row
        end

        TransformerResult.new(message: 'Transformer success: data downcased',
                              mable_etl_data: result)
      end
    end
  end
end
