# frozen_string_literal: true

require 'pry'
require 'loaders/active_record_loader'

# FactoryLoader.generate(params).load
# The object contains the class, data and config for loader

module MableEtl
  class Loaders
    class LoaderFactory

      def self.for(params)
        class_eval("MableEtl::Loaders::#{params[:loader_type]}", __FILE__, __LINE__).new(params).load
      end
    end
  end
end
