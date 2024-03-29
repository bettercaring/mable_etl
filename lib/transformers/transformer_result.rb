# frozen_string_literal: true

module MableEtl
  class Transformers
    class TransformerResult
      include LoggerHelper

      def initialize(message:, mable_etl_data:, success: true)
        @success = success
        @message = message
        @mable_etl_data = mable_etl_data
      end

      def success?
        success
      end

      attr_reader :mable_etl_data

      private

      attr_reader :message, :success
    end
  end
end
