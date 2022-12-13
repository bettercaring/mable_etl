# frozen_string_literal: true

module MableEtl
  class Transformers
    class TransformerResult
      def initialize(message:, mable_etl_data:, success: true)
        @success = success
        @message = message
        @mable_etl_data = mable_etl_data
      end

      def success?
        success
      end

      attr_reader :message, :mable_etl_data, :success
    end
  end
end
