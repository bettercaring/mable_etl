# frozen_string_literal: true

require 'dry/validation'

module MableEtl
  module Contracts
    class TransformerFactoryContract < Dry::Validation::Contract
      params do
        required(:transformer_type).filled
      end
    end
  end
end
