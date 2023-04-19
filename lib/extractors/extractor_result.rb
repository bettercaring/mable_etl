# frozen_string_literal: true

module MableEtl
  class Extractors
    class ExtractorResult
      include MableEtl::LoggerHelper

      def initialize(message:, mable_etl_file_path:, success: true)
        @success = success
        @message = message
        @mable_etl_file_path = mable_etl_file_path
      end

      def success?
        success
      end

      attr_reader :message, :mable_etl_file_path, :success
    end
  end
end
