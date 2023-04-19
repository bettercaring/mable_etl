# frozen_string_literal: true

require_relative '../contracts/active_record_loader_contract'
require 'mable_etl/errors/loaders/active_record_loader'
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
        @silence_log_config = params[:silence_log]
        @logger = params[:logger]
        @inserted_count = 0
      end

      def load
        slience_log do
          @data.in_groups_of(10_000) do |group|
            @inserted_count += @active_record_model_name.insert_all(group.compact).count
          end
        end

        LoaderResult.new(message: "Load success: #{inserted_count}/#{@data.count} records inserted.")
      end

      private

      attr_reader :inserted_count

      def slience_log(&block)
        if @silence_log_config
          @logger.silence do
            block.call
          end
        else
          yield
        end
      end
    end
  end
end
