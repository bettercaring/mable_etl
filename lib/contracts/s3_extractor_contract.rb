require 'dry/validation'

module MableEtl
  module Contracts
    class S3ExtractorContract < Dry::Validation::Contract
      params do
        required(:s3_path).value(:string)
        required(:s3_bucket).value(:string)
        required(:s3_credentials).value(:hash)
      end

      rule(:s3_path) do
        key.failure('file must exist') unless File.exist?(value)
      end
    end
  end
end