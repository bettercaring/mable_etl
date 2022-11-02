require 'dry/validation'

module MableEtl
  module Contracts
    class LoaderFactoryContract < Dry::Validation::Contract
      params do
        required(:loader_type).filled
      end
    end
  end
end