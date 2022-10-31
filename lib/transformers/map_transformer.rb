# frozen_string_literal: true

require 'pry'

module MableEtl
  class Transformers
    class MapTransformer
      attr_accessor :params

      def initialize(params)
        validations(params)

        @data = params[:data]
      end

      def transform
        @data.map(&:to_h)
      end

      def validations(params)
        raise MableEtl::Errors::Transformers::MapTransformer, 'data is missing' if params[:data].nil?
      end
    end
  end
end