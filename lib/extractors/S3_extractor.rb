# frozen_string_literal: true

require 'pry'
require 'csv'
# require 'mable_etl/errors/extractors/S3_extractor'

module MableEtl
  class Extractors
    class S3Extractor
      attr_accessor :params

      def initialize(params)
        validation(params)
        @S3_credentials = params[:S3_credentials]
        @S3_region = params[:S3_region]
        @S3_path = params[:S3_path]
        @S3_bucket = params[:S3_bucket]
      end

      def extract
        s3 = Aws::S3::Client.new(region: params[:S3_region],
                credentials: params[:S3_credentials])
        resp = s3.get_object({ bucket: 'mable.production.inf-datascience.ds-data-lake-acquisition', key: 's3://mable.production.inf-datascience.ds-data-lake-acquisition/svc_job_digests_2022-10-28.csv' }, target: 'lib/temp/')
        #key: object-key
      end

      #       def extract
      #         # extract files from S3
      #         FileUtils.cp(S3_path, 'lib/temp/')
      #       end

      def validation(params)
        raise MableEtl::Errors::Extractors::S3Extractor, 'path is missing' if params[:S3_path].nil?
      end
    end
  end
end
