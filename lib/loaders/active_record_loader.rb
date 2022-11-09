# frozen_string_literal: true

require 'pry'
require_relative '../contracts/active_record_loader_contract'
require_relative '../helpers/validation'

module MableEtl
  class Loaders
    class ActiveRecordLoader
      prepend Validation
      attr_accessor :params

      validation_options contract_klass: MableEtl::Contracts::ActiveRecordLoaderContract,
                         error_klass: MableEtl::Errors::Loaders::ActiveRecordLoader

      def initialize(params)
        @active_record_model_name = params[:config_model_name].constantize
        @data = params[:mable_etl_data]
      end

      def load
        unless @active_record_model_name.insert_all(@data)
          raise MableEtl::Errors::Loaders::ActiveRecordLoader, 'Could not save'
        end

        @active_record_model_name.insert_all(@data)
      end
    end
  end
end
