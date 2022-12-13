require 'dry/validation'

module MableEtl
  module Contracts
    class ActiveRecordLoaderContract < Dry::Validation::Contract
      params do
        required(:config_model_name).value(:string)
        required(:mable_etl_data).value(:array)
      end
    end
  end
end
