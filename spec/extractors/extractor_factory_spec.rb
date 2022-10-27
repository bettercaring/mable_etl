require 'spec_helper'
require 'extractors/extractor_factory'

RSpec.describe MableEtl::Extractors::ExtractorFactory do
  subject(:extractor_factory) { described_class.for(params) }
  let(:params) do
    {
      extractor_type: 'CSV',
      file_type: 'spec/fixtures/files/test.csv'
    }
  end

  let(:csv) { instance_double(MableEtl::Extractors::CSV) }
  let(:extractor_result) { true }

  before do
    allow(MableEtl::Extractors::CSV).to receive(:new).and_return(csv)
    allow(csv).to receive(:extract).and_return(extractor_result)
  end

  describe 'extractor factory' do
    it 'sends data to the correct extractor' do
      expect(extractor_factory).to eq(extractor_result)
    end

    context 'error' do
      before do
        params[:extractor_type] = nil
      end
      it 'raises error when extractor_type nil' do
        expect { extractor_factory }.to raise_error(MableEtl::Errors::Extractors::ExtractorFactory)
      end
    end
  end
end