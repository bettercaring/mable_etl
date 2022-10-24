# frozen_string_literal: true
require 'pry'
require 'loaders/active_record_loader'

# FactoryLoader.generate(data, config.loader, loader_type).load
# The object contains the class, data and config for loader

module MableEtl
  class Loaders
    class LoaderFactory
      # sends the data to the right class

      def self.for(data, config_loader, loader_type)
        binding.pry
        class_eval("MableEtl::Loaders::#{loader_type}").new(data, config_loader).load
      end
    end
  end
end
