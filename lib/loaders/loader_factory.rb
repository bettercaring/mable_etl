# frozen_string_literal: true

require 'pry'
require 'mable_etl/errors/loaders/loader_factory'
require 'loaders/active_record_loader'

# FactoryLoader.generate(params).load
# The object contains the class, data and config for loader

module MableEtl
  class Loaders
    class LoaderFactory
      def self.for(params)
        raise MableEtl::Errors::Loaders::LoaderFactory, 'loader_type is missing' if params[:loader_type].nil?

        class_eval("MableEtl::Loaders::#{params[:loader_type]}", __FILE__, __LINE__).new(params).load
      end
    end
  end
end
