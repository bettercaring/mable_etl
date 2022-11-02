require 'dry/validation'

module MableEtl
  module Contracts
    class ExtractorFactoryContract < Dry::Validation::Contract
      params do
        required(:extractor_type).filled
      end
    end
  end
end