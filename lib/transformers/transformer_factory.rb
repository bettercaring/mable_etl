# frozen_string_literal: true

require 'pry'
require 'mable_etl/errors/transformers/transformer_factory'
require 'transformers/map_transformer'
require 'transformers/csv_object_transformer'

# TransformerFactory.for(params).transform
# The object contains the class, data and config for loader

module MableEtl
  class Transformers
    class TransformerFactory
      def self.for(params)
        raise MableEtl::Errors::Transformers::TransformerFactory, 'transformer_type is missing' if params[:transformer_type].nil?

        class_eval("MableEtl::Transformers::#{params[:transformer_type]}", __FILE__, __LINE__).new(params).transform
      end
    end
  end
end