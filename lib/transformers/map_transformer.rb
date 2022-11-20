# frozen_string_literal: true

require 'pry'
require_relative '../contracts/map_transformer_contract'
require_relative './transformer_result'

module MableEtl
  class Transformers
    class MapTransformer
      def initialize(params)
        @params = params

        validation

        @data = params[:mable_etl_data]
      end

      def transform
        result = @data.map(&:to_h)

        TransformerResult.new(message: "Transformer success: #{@data} mapped to a hash",
                              mable_etl_data: result)
      end

      private

      attr_reader :params, :contract_result

      def validation
        contract_result = MableEtl::Contracts::MapTransformerContract.new.call(params)

        return if contract_result.success?

        raise MableEtl::Errors::Transformers::MapTransformer, contract_result.errors.to_h.to_s
      end
    end
  end
end
