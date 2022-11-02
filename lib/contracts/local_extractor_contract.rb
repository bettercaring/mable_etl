require 'dry/validation'

module MableEtl
  module Contracts
    class LocalExtractorContract < Dry::Validation::Contract
      params do
        required(:file_path).value(:string)
      end

      rule(:file_path) do
        key.failure('file must exist') unless File.exist?(value)
      end
    end
  end
end