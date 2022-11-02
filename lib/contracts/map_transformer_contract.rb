require 'dry/validation'

module MableEtl
  module Contracts
    class MapTransformerContract < Dry::Validation::Contract
      params do
        required(:data).filled
      end
    end
  end
end