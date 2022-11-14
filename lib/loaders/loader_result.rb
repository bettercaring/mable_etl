module MableEtl
  class Loaders
    class LoaderResult
      def initialize(message:, success: true)
        @success = success
        @message = message
      end

      def success?
        success
      end

      attr_reader :message, :success
    end
  end
end