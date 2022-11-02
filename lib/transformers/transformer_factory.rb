# frozen_string_literal: true

require 'pry'
require 'mable_etl/errors/transformers/transformer_factory'
require_relative '../contracts/transformer_factory_contract'
require 'transformers/map_transformer'
require 'transformers/csv_object_transformer'

# TransformerFactory.for(params).transform
# The object contains the class, data and config for loader

module MableEtl
  class Transformers
    class TransformerFactory
      def self.for(params)
        validations(params)

        class_eval("MableEtl::Transformers::#{params[:transformer_type]}", __FILE__, __LINE__).new(params).transform
      end

      def self.validations(params)
        contract_result = MableEtl::Contracts::TransformerFactoryContract.new.call(params)

        return if contract_result.success?

        raise MableEtl::Errors::Transformers::TransformerFactory, contract_result.errors.to_h.to_s
      end
    end
  end
end
