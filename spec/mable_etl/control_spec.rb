# frozen_string_literal: true

require 'spec_helper'
require 'mable_etl/control'
require 'fixtures/dummy_logger'

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
      logger: dummy_logger
    }
  end
  let(:dummy_logger) { DummyLogger.new }

  before do
    allow(dummy_logger).to receive(:info).with(any_args)
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
