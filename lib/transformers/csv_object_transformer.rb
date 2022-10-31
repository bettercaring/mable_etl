# frozen_string_literal: true

require 'pry'
require 'csv'

module MableEtl
  class Transformers
    class CsvObjectTransformer
      attr_accessor :params

      def initialize(params)
        validations(params)

        @file_path = params[:file_path]
      end

      def transform
        ::CSV.parse(File.read(@file_path), headers: true)
      end

      def validations(params)
        raise MableEtl::Errors::Transformers::CsvObjectTransformer, 'data is missing' if params[:file_path].nil?
      end
    end
  end
end