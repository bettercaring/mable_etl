# frozen_string_literal: true

require 'pry'

module MableEtl
  class Loader
    class MableDatabase
        #psuedocode for loader
      attr_accessor :data

      def initialize(data)
        @table_name = config.db_table_name
        @data = data
      end

      def load
        # result = JobDigest.insert_all(data)
        # puts result.inspect
        # puts JobDigest.count
        table_name.insert_all(data)
      end
    end
  end
end