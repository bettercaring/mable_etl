# frozen_string_literal: true

require 'spec_helper'
require 'loaders/loader_result'

RSpec.describe MableEtl::Loaders::LoaderResult do
  subject(:result) do
    described_class.new(message: 'message', success: true)
  end

  describe '#log' do
    subject(:log) { result.log }

    it { is_expected.to eq 'Mable Etl - message' }
  end
end
