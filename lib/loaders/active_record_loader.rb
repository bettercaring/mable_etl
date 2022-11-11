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
        @data = params[:mable_etl_data]
      end

      def load
        result_2 = @active_record_model_name.insert_all([Array.new(3).flat_map {|arr| { email: "testEmail#{rand(100)}", name: "testName#{rand(100)}" } }].flatten)

        result_1 = @active_record_model_name.insert_all([Array.new(3).flat_map {|arr| { email: "testEmail#{rand(100)}", name: "testName#{rand(100)}" } }].flatten)

        result_4 = @active_record_model_name.insert_all([{}])

        unless result_3 = @active_record_model_name.insert_all(@data)
          # binding.pry
          raise MableEtl::Errors::Loaders::ActiveRecordLoader, 'Could not save'
        end
        puts '----------------'
        puts result_1.inspect
        puts '----------------'
        puts result_2.inspect
        puts '----------------'
        puts result_3.inspect
        puts '----------------'
        puts result_4.inspect

        @active_record_model_name.count
        @active_record_model_name.all
        binding.pry
      end

      def validations(params)
        contract_result = MableEtl::Contracts::ActiveRecordLoaderContract.new.call(params)

        return if contract_result.success?

        raise MableEtl::Errors::Loaders::ActiveRecordLoader, contract_result.errors.to_h.to_s
      end
    end
  end
end
