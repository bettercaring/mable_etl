# frozen_string_literal: true

require 'pry'
require 'csv'

module MableEtl
  class Extractor
    class Reader
      # file_type, format & db model name
      # handle multiple file locations & formats
      attr_accessor :file

      def initialize(file)
        @file = file
      end

      def read_csv
        CSV.read(File.path(@file))
      end
    end
  end
end
