# frozen_string_literal: true

require 'aws-sdk-s3'
require 'pry'
require 'csv'
require_relative '../contracts/s3_extractor_contract'
require 'mable_etl/errors/extractors/s3_extractor'

module MableEtl
  class Extractors
    class S3Extractor
      prepend Validation
      attr_accessor :params

      validation_options contract_klass: MableEtl::Contracts::S3ExtractorContract,
                         error_klass: MableEtl::Errors::Extractors::S3Extractor

      def initialize(params)
        @s3_credentials = params[:s3_credentials]
        @s3_path = params[:s3_path]
        @s3_bucket = params[:s3_bucket]
        @temp_file = params[:temp_file]
      end

      def extract
        s3 = Aws::S3::Client.new(access_key_id: @s3_credentials[:access_key_id],
                                 secret_access_key: @s3_credentials[:secret_access_key])
        s3.get_object({ response_target: @temp_file, bucket: @s3_bucket, key: @s3_path })
      end
    end
  end
end
