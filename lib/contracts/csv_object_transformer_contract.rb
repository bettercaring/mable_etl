# frozen_string_literal: true

require 'dry/validation'

module MableEtl
  module Contracts
    class CsvObjectTransformerContract < Dry::Validation::Contract
      params do
        required(:mable_etl_file_path).value(:string)
      end

      rule(:mable_etl_file_path) do
        key.failure('file must exist') unless File.exist?(value)
      end
    end
  end
end
