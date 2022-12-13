# frozen_string_literal: true

require 'dry/validation'

module MableEtl
  module Contracts
    class MapTransformerContract < Dry::Validation::Contract
      params do
        required(:mable_etl_data).filled
      end
    end
  end
end
