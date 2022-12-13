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
      transformer_types: %w[CsvObjectTransformer MapTransformer DowncaseTransformer],
      config_model_name: 'User',
      loader_type: 'ActiveRecordLoader',
      downcase_columns: ['name'],
      logger: dummy_logger
    }
  end

  let(:dummy_logger) { DummyLogger.new }
  let(:loader_result) { instance_double(MableEtl::Loaders::LoaderResult) }
  let(:message) { 'Extract success: local file spec/fixtures/files/test.csv extracted to temp folder' }

  before do
    allow(dummy_logger).to receive(:info).with(any_args)
    allow(dummy_logger).to receive(:error).with(any_args)
    allow(MableEtl::Loaders::LoaderResult).to receive(:new).and_return(loader_result)
  end

  describe '#process' do
    context 'is successful' do
      it 'is returns a loader object' do
        expect(control.process).to eq(loader_result)
      end
    end

    context 'extractor and transformer' do
      let(:extract) do
        instance_double(MableEtl::Extractors::ExtractorResult, success?: success, mable_etl_file_path: 'temp/test.csv',
                                                               message: 'abc')
      end

      let(:transform) do
        instance_double(MableEtl::Transformers::TransformerResult, success?: success, mable_etl_data: mable_etl_data,
                                                                   message: 'def')
      end
      let(:success) { true }
      let(:mable_etl_data) do
        [{ 'name' => 'Mable', 'id' => '1' },
         { 'name' => 'better_caring', 'id' => '2' }]
      end

      before do
        allow(MableEtl::Extractors::ExtractorResult).to receive(:new).and_return(extract)
        allow(MableEtl::Transformers::TransformerResult).to receive(:new).and_return(transform)
      end

      context 'when it is successful' do
        it 'should receive info' do
          dummy_logger = double
          allow(dummy_logger).to receive(:info).and_return(extract.message, transform.message)

          control.process
          expect(dummy_logger.info).to eq(extract.message)
          expect(dummy_logger.info).to eq(transform.message)
        end

        context 'when it is unsuccessful' do
          let(:success) { false }
          it 'it returns a logger error' do
            dummy_logger = double
            allow(dummy_logger).to receive(:error).and_return(extract.message, transform.message)

            control.process
            expect(dummy_logger.error).to eq(extract.message)
            expect(dummy_logger.error).to eq(transform.message)
          end
        end
      end
    end
  end
end
