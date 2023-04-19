# frozen_string_literal: true

require 'spec_helper'
require 'transformers/transformer_result'

RSpec.describe MableEtl::Transformers::TransformerResult do
  subject(:result) do
    described_class.new(message: 'message', mable_etl_data: [], success: true)
  end

  describe '#log' do
    subject(:log) { result.log }

    it { is_expected.to eq 'Mable Etl - message' }
  end
end
