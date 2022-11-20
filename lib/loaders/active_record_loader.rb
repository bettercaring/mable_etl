# frozen_string_literal: true

require 'pry'
require_relative '../contracts/active_record_loader_contract'
require_relative '../helpers/validation'
require_relative './loader_result'

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
        @active_record_model_name.insert_all(@data)

        LoaderResult.new(message: "Load success: #{@data.count} loaded and #{records} exist.")
      end

      def records
        @records ||= @active_record_model_name.where(query).count
      end

      def query
        @data.map { |record_data| record_data_query(record_data) }.join(' OR ')
      end

      def record_data_query(record)
        record.map { |name, value| "#{name} = '#{value}'" }.join(' AND ')
      end
    end
  end
end
