# frozen_string_literal: true

require 'spec_helper'
require 'mable_etl/control'

RSpec.describe MableEtl::Control do
  subject(:control) { described_class.new(params) }
  let(:params) do
    {
      extractor_type: 'LocalExtractor',
      file_path: 'spec/fixtures/files/test.csv',
      transformer_types: ['CsvObjectTransformer', 'MapTransformer', 'DowncaseTransformer'],
      config_model_name: 'User',
      loader_type: 'ActiveRecordLoader',
      downcase_columns: ['name'],
      logger: logger
    }
  end
  let(:logger) { instance_double(Rails) }

  before do
    allow(Rails).to receive(:logger).and_return(logger)
    # allow(logger).to receive(:info).and_return('something')
  end

  describe '#process' do
    context 'is successful' do
      let(:loader_result) { instance_double(MableEtl::Loaders::LoaderResult) }

      before do
        allow(MableEtl::Loaders::LoaderResult).to receive(:new).and_return(loader_result)
      end
      it 'is returns a loader object' do
        binding.pry
        expect(control.process).to eq(loader_result)
      end
    end
  end
end
