# frozen_string_literal: true

require 'pry'

module MableEtl
  class Loaders
    class ActiveRecordLoader
      attr_accessor :data

      def initialize(config, data)
        @table_name = config.name.constantize
        @data = data
      end

      def load
        @table_name.insert_all(data)
      end
    end
  end
end
