# frozen_string_literal: true

require 'spec_helper'
require 'mable_etl/control'
require 'fixtures/dummy_logger'

RSpec.describe MableEtl::Control do
  subject(:control) { described_class.new(params) }
  let(:params) do
    {
      extractor_type: extractor_type,
      file_path: file_path,
      transformer_types: %w[CsvObjectTransformer MapTransformer DowncaseTransformer],
      config_model_name: 'User',
      loader_type: 'ActiveRecordLoader',
      downcase_columns: ['name'],
      logger: dummy_logger
    }
  end
  let(:extractor_type) { 'LocalExtractor' }
  let(:file_path) { 'spec/fixtures/files/test.csv' }
  let(:dummy_logger) { DummyLogger.new }
  let(:loader_result) { instance_double(MableEtl::Loaders::LoaderResult) }

  before do
    allow(dummy_logger).to receive(:info).with(any_args)
    allow(MableEtl::Loaders::LoaderResult).to receive(:new).and_return(loader_result)
  end

  describe '#process' do
    context 'is successful' do
      it 'is returns a loader object' do
        expect(control.process).to eq(loader_result)
      end
    end

    context 'extractor' do
      context 'when it is successful' do
        it 'should receive info' do
          expect(dummy_logger).to receive(:info)
          control.process
        end

        context 'when it is successful' do
          let(:extract) { instance_double(MableEtl::Extractors::ExtractorResult, success?: false, mable_etl_file_path: 'file_path', message: 'abc') }

          before do
            allow(MableEtl::Extractors::ExtractorResult).to receive(:new).and_return(extract)
          end
          it 'it returns a logger error' do
            expect(dummy_logger).to receive(:error)
            control.process
          end
        end
      end
    end
  end
end
