# frozen_string_literal: true

require 'spec_helper'
require 'mable_etl/control'

RSpec.describe MableEtl::Control do
  subject(:control) { described_class.new(params) }

  let(:params) do
    {
      extractor_type: 'LocalExtractor',
      file_path: 'spec/fixtures/files/test.csv',
      transformer_types: %w[CsvObjectTransformer MapTransformer],
      config_model_name: 'User',
      loader_type: 'ActiveRecordLoader'
    }
  end

  describe '#process' do
    context 'is successful' do
      let(:loader_result) { instance_double(MableEtl::Loaders::LoaderResult) }

      before do
        allow(MableEtl::Loaders::LoaderResult).to receive(:new).and_return(loader_result)
      end

      it 'is returns a loader object' do
        expect(control.process).to eq(loader_result)
      end
    end
  end
end
