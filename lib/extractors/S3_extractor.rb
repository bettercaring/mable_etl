# frozen_string_literal: true

require 'pry'
require 'csv'
require 'mable_etl/errors/extractors/S3_extractor'

module MableEtl
  class Extractors
    class S3Extractor
      attr_accessor :params

      def initialize(params)
        validation(params)

        @S3_path = params[:S3_path]
      end

      def extract
        #extract files from S3
      end

      def validation(params)
        raise MableEtl::Errors::Extractors::S3Extractor, 'path is missing' if params[:S3_path].nil?
      end
    end
  end
end
