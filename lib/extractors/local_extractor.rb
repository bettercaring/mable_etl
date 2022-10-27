# frozen_string_literal: true

require 'pry'
require 'csv'
require 'mable_etl/errors/extractors/local_extractor'

module MableEtl
  class Extractors
    class LocalExtractor
      attr_accessor :params

      def initialize(params)
        validation(params)

        @file_path = params[:file_path]
      end

      def extract
        # files with no headers
        ::CSV.parse(File.read(@file_path), headers: true).map(&:to_h)
      end

      def validation(params)
        raise MableEtl::Errors::Extractors::LocalExtractor, 'file is missing' if params[:file_path].nil?
      end
    end
  end
end
