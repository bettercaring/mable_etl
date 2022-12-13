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
    allow(dummy_logger).to receive(:error)
    allow(dummy_logger).to receive(:info)

    allow(MableEtl::Loaders::LoaderResult).to receive(:new).and_return(loader_result)
  end

  describe '#process' do
    context 'is successful' do
      it 'is returns a loader object' do
        expect(control.process).to eq(loader_result)
      end
    end

    describe 'logging' do
      before do
        allow(MableEtl::Extractors::ExtractorResult).to receive(:new).and_return(extract)
        allow(MableEtl::Transformers::TransformerResult).to receive(:new).and_return(transform)

        control.process
      end

      let(:extract) do
        instance_double(MableEtl::Extractors::ExtractorResult, success?: extract_success, mable_etl_file_path: 'temp/test.csv',
                                                               message: 'abc')
      end

      let(:transform) do
        instance_double(MableEtl::Transformers::TransformerResult, success?: transform_success, mable_etl_data: mable_etl_data,
                                                                   message: 'def')
      end

      let(:mable_etl_data) do
        [{ 'name' => 'Mable', 'id' => '1' },
         { 'name' => 'better_caring', 'id' => '2' }]
      end

      context 'when extract and transform successful' do
        let(:extract_success) { true }
        let(:transform_success) { true }

        it 'should log info', :aggregate_failures do
          expect(dummy_logger).to have_received(:info).with(extract.message)
          expect(dummy_logger).to have_received(:info).with(transform.message).exactly(3).times
        end
      end

      context 'when extract and transform unsuccessful' do
        let(:extract_success) { false }
        let(:transform_success) { false }

        it 'should log extract error', :aggregate_failures do
          expect(dummy_logger).to have_received(:error).with(extract.message)
        end

        it 'should not log transform error', :aggregate_failures do
          expect(dummy_logger).not_to have_received(:error).with(transform.message)
        end
      end

      context 'when extract successful and transform unsuccessful' do
        let(:extract_success) { true }
        let(:transform_success) { false }

        it 'should log extract info' do
          expect(dummy_logger).to have_received(:info).with(extract.message)
        end

        it 'should log transform error' do
          expect(dummy_logger).to have_received(:error).with(transform.message).once
        end
      end

      context 'when extract unsuccessful and transform successful' do
        let(:extract_success) { false }
        let(:transform_success) { true }

        it 'should log extract error', :aggregate_failures do
          expect(dummy_logger).to have_received(:error).with(extract.message)
        end

        it 'should not log transform error' do
          expect(dummy_logger).not_to have_received(:info).with(transform.message)
        end
      end
    end
  end
end
