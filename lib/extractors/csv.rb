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

      def read
        ::CSV.read(File.path(@file_path))
      end
    end
  end
end