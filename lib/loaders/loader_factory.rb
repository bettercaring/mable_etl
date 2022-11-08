# frozen_string_literal: true

require 'pry'
require_relative '../contracts/loader_factory_contract'
require 'mable_etl/errors/loaders/loader_factory'
require 'loaders/active_record_loader'

# FactoryLoader.generate(params).load
# The object contains the class, data and config for loader

module MableEtl
  class Loaders
    class LoaderFactory
      def self.for(params)
        validations(params)

        class_eval("MableEtl::Loaders::#{params[:loader_type]}", __FILE__, __LINE__).new(params)
      end

      def self.validations(params)
        contract_result = MableEtl::Contracts::LoaderFactoryContract.new.call(params)

        return if contract_result.success?

        raise MableEtl::Errors::Loaders::LoaderFactory, contract_result.errors.to_h.to_s
      end
    end
  end
end
