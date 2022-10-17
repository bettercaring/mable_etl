# frozen_string_literal: true

require 'pry'

module MableEtl
  class Loader
    class MableDatabase
        #psuedocode for loader
      attr_accessor :table_name, :table_columns

      def initialize(table_name)
        @table_name = table_name
        @table_columns = table_columns
      end

      def load
        # result = JobDigest.insert_all(data)
        # puts result.inspect
        # puts JobDigest.count
        JobDigest.insert_all(table_columns)
      end
    end
  end
end