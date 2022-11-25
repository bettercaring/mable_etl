# frozen_string_literal: true

require 'aws-sdk-s3'
require 'csv'
require_relative '../contracts/s3_extractor_contract'
require 'mable_etl/errors/extractors/s3_extractor'
require_relative './extractor_result'

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
        @tmp_folder_path = params[:tmp_folder_path]
      end

      def extract
        s3 = Aws::S3::Client.new(
          access_key_id: @s3_credentials[:access_key_id],
          secret_access_key: @s3_credentials[:secret_access_key]
        )

        s3_object = s3.get_object(
          {
            response_target: tmp_file_path,
            bucket: @s3_bucket,
            key: @s3_path
          }
        )

        @tmp_file_path if s3_object.present?

        ExtractorResult.new(message: "Extract success: S3 file #{@s3_path} extracted successfully",
                            mable_etl_file_path: tmp_file_path)
      end

      def etl_tmp_folder_path
        @etl_tmp_folder_path ||= FileUtils.mkdir_p([@tmp_folder_path, 'mable_etl'].join('/')).first
      end

      def tmp_file_path
        @tmp_file_path ||= [etl_tmp_folder_path, File.basename(@s3_path)].join('/')
      end
    end
  end
end
