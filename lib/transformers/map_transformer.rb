# frozen_string_literal: true

require 'pry'
require 'mable_etl/errors/transformers/map_transformer'
require_relative '../contracts/map_transformer_contract'
require_relative '../helpers/validation'

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
        @data.map(&:to_h)
      end
    end
  end
end

