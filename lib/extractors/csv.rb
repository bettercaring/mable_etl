# frozen_string_literal: true

require 'pry'
require 'csv'

module MableEtl
  class Extractors
    class CSV
      # file_type, format & db model name
      # handle multiple file locations & formats
      attr_accessor :file_path

      def initialize(file_path)
        @file_path = file_path
      end

      def extract
        # files with no headers
        # an error as well
        ::CSV.parse(File.read(@file_path), headers: true).map(&:to_h)
      end
    end
  end
end
