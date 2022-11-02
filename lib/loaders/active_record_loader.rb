# frozen_string_literal: true

require 'pry'
require_relative '../contracts/active_record_loader_contract'

module MableEtl
  class Loaders
    class ActiveRecordLoader
      attr_accessor :params

      def initialize(params)
        validations(params)

        @active_record_model_name = params[:config_model_name].constantize
        @data = params[:data]
      end

      def load
        @active_record_model_name.insert_all(@data)
      end

      def validations(params)
        contract_result = MableEtl::Contracts::ActiveRecordLoaderContract.new.call(params)

        return if contract_result.success?

        raise MableEtl::Errors::Loaders::ActiveRecordLoader, contract_result.errors.to_h.to_s
      end
    end
  end
end
