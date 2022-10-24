# frozen_string_literal: true

require 'pry'

module MableEtl
  class Loaders
    class ActiveRecordLoader
      attr_accessor :data, :config_table_name

      def initialize(data, config_table_name)
        @table_name = config_table_name
        @data = data
      end

      def load
        @table_name.insert_all(data)
      end
    end
  end
end
