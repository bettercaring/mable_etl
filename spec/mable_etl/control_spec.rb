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

    context 'extractor' do
      context 'when it is successful' do
        it 'should receive info' do
          control.process
          expect(dummy_logger).to have_received(:info).with(message)
        end

        context 'when it is unsuccessful' do
          let(:extract) { instance_double(MableEtl::Extractors::ExtractorResult, success?: false, mable_etl_file_path: 'file_path', message: 'abc') }

          before do
            allow(MableEtl::Extractors::ExtractorResult).to receive(:new).and_return(extract)
          end
          it 'it returns a logger error' do
            control.process
            expect(dummy_logger).to have_received(:error).with('abc')
          end
        end
      end

      context 'transformer' do
        context 'when it is successful' do
          let(:message) { 'Transformer success: temp/test.csv transformed to CSV object' }
          it 'should receive info' do
            control.process
            expect(dummy_logger).to have_received(:info).with(message)
          end

          context 'when it is unsuccessful' do
            let(:transform) { instance_double(MableEtl::Transformers::TransformerResult, success?: false, mable_etl_data: 'file_path', message: 'abc') }

            before do
              allow(MableEtl::Transformers::TransformerResult).to receive(:new).and_return(transform)
            end
            it 'it returns a logger error' do
              # control.process
              control.send(:log_result, transform)
              # binding.pry
              expect(dummy_logger).to have_received(:error).with('abc')
            end
          end
        end
      end
    end
  end
end
