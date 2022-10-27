# frozen_string_literal: true

require 'pry'

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
        raise MableEtl::Errors::Loaders::ActiveRecordLoader, 'config_model_name is missing' if params[:config_model_name].nil?

        raise MableEtl::Errors::Loaders::ActiveRecordLoader, 'data is missing' if params[:data].nil?
      end
    end
  end
end
