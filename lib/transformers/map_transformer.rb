# frozen_string_literal: true

require 'mable_etl/errors/transformers/map_transformer'
require_relative '../contracts/map_transformer_contract'
require_relative '../helpers/validation'
require_relative './transformer_result'

module MableEtl
  class Transformers
    class MapTransformer
      prepend Validation
      attr_accessor :params

      validation_options contract_klass: MableEtl::Contracts::MapTransformerContract,
                         error_klass: MableEtl::Errors::Transformers::MapTransformer

      def initialize(params)
        @data = params[:mable_etl_data]
      end

      def transform
        result = @data.map(&:to_h)

        TransformerResult.new(message: "Transformer success: #{@data} mapped to a hash",
                              mable_etl_data: result)
      end
    end
  end
end
