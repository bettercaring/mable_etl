# frozen_string_literal: true

require 'spec_helper'
require 'extractors/extractor_factory'

RSpec.describe MableEtl::Extractors::ExtractorFactory do
  subject(:extractor_factory) { described_class.for(params) }

  let(:params) do
    {
      extractor_type: 'LocalExtractor',
      file_type: 'spec/fixtures/files/test.csv'
    }
  end

  let(:local_extractor) { instance_double(MableEtl::Extractors::LocalExtractor) }

  before do
    allow(MableEtl::Extractors::LocalExtractor).to receive(:new).and_return(local_extractor)
  end

  describe 'extractor factory' do
    it 'sends data to the correct extractor' do
      expect(extractor_factory).to eq(local_extractor)
    end

    context 'error' do
      before do
        params[:extractor_type] = nil
      end

      it 'raises error when extractor_type nil' do
        expect do
          extractor_factory
        end.to raise_error(MableEtl::Errors::Extractors::ExtractorFactory, { extractor_type: ['must be filled'] }.to_s)
      end
    end
  end
end
