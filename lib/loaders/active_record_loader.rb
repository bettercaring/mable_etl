# frozen_string_literal: true

require 'pry'

module MableEtl
  class Loaders
    class ActiveRecordLoader
      attr_accessor :params

      def initialize(params)
        @table_name = params[:config_table_name]
        @data = params[:data]
      end

      def load
        @table_name.insert_all(@data)
      end
    end
  end
end
