require 'dry/validation'

module MableEtl
  module Contracts
    class ActiveRecordLoaderContract < Dry::Validation::Contract
      params do
        required(:config_model_name).value(:string)
        required(:data).value(:array)
      end
    end
  end
end