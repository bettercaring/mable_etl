# frozen_string_literal: true

module MableEtl
  module Validation
    def self.prepended(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      def validation_options(contract_klass:, error_klass:)
        @contract_klass = contract_klass
        @error_klass = error_klass
      end

      def contract_klass
        @contract_klass
      end

      def error_klass
        @error_klass
      end
    end

    def initialize(params)
      validations(params)
      super(params)
    end

    private

    def validations(params)
      contract_result = self.class.contract_klass.new.call(params)

      return if contract_result.success?

      raise self.class.error_klass, contract_result.errors.to_h.to_s
    end
  end
end
