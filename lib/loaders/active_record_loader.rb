# frozen_string_literal: true

require 'pry'

module MableEtl
  class Loaders
    class ActiveRecordLoader
      attr_accessor :params

      def initialize(params)
        # will need to chat about the config table name changing to config model name
        @active_record_model_name = params[:config_model_name]
        @data = params[:data]
      end

      def load
        @active_record_model_name.insert_all(@data)
      end
    end
  end
end
