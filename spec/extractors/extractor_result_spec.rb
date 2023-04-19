# frozen_string_literal: true

require 'spec_helper'
require 'extractors/extractor_result'

RSpec.describe MableEtl::Extractors::ExtractorResult do
  subject(:result) do
    described_class.new(message: 'message', mable_etl_file_path: [], success: true)
  end

  describe '#log' do
    subject(:log) { result.log }

    it { is_expected.to eq 'Mable Etl - message' }
  end
end
