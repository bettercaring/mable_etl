require 'dry/validation'

module MableEtl
  module Contracts
    class DowncaseTransformerContract < Dry::Validation::Contract
      params do
        required(:mable_etl_data).filled
        required(:downcase_columns).filled
      end
    end
  end
end
