# frozen_string_literal: true

require 'spec_helper'
require 'mable_etl/errors/loaders/active_record_loader'
require 'loaders/active_record_loader'

class DummyLogger
  def silence
    yield
  end
end

RSpec.describe MableEtl::Loaders::ActiveRecordLoader do
  subject(:active_record_loader) { described_class.new(params) }

  let(:params) do
    {
      config_model_name: 'User',
      mable_etl_data: mable_etl_data,
      silence_log: silence_log,
      logger: logger
    }
  end

  let(:logger) { DummyLogger.new }
  let(:mable_etl_data) do
    [{ id: 1, name: 'name', email: 'chicken@gmail.com' },
     { id: 1, name: 'gerald', email: 'chicken@gmail.com' },
     { id: 2, name: 'hello', email: 'hello@gmail.com' }]
  end
  let(:silence_log) { true }

  describe '#initialize' do
    context 'with valid params' do
      it 'does not raise error' do
        expect { active_record_loader }.not_to raise_error
      end
    end

    context 'with invalid params' do
      context 'when config_model_name is nil' do
        before do
          params[:config_model_name] = nil
        end

        it 'raises error' do
          expect do
            active_record_loader
          end.to raise_error(MableEtl::Errors::Loaders::ActiveRecordLoader,
                             { config_model_name: ['must be a string'] }.to_s)
        end
      end

      context 'when data is nil' do
        before do
          params[:mable_etl_data] = nil
        end

        it 'raises error' do
          expect do
            active_record_loader
          end.to raise_error(MableEtl::Errors::Loaders::ActiveRecordLoader,
                             { mable_etl_data: ['must be an array'] }.to_s)
        end
      end
    end
  end

  describe '#load' do
    subject(:load_subject) { active_record_loader.load }

    let(:loader_result) { instance_double(MableEtl::Loaders::LoaderResult) }

    context 'when successful' do
      before do
        allow(MableEtl::Loaders::LoaderResult).to receive(:new).with(
          message: 'Load success: 0/3 records inserted.'
        ).and_return(loader_result)

        allow(logger).to receive(:silence).and_call_original

        load_subject
      end

      it 'adds the data to the table' do
        expect(User.count).to eq(2)
      end

      it 'returns a loader result' do
        expect(load_subject).to eq loader_result
      end

      it 'does not add duplicate data to the table' do
        expect(User.pluck(:id)).to eq([1, 2])
      end

      context 'when log is silenced' do
        let(:silence_log) { true }

        it 'silences the log' do
          expect(logger).to have_received(:silence)
        end
      end

      context 'when log is not silenced' do
        let(:silence_log) { false }

        it 'does not silence the log' do
          expect(logger).not_to have_received(:silence)
        end
      end
    end

    context 'when unsuccessful' do
      let(:mable_etl_data) do
        [{ id: 1, age: 'name', email: 'chicken@gmail.com' },
         { id: 1, age: 'gerald', email: 'chicken@gmail.com' },
         { id: 2, age: 'hello', email: 'hello@gmail.com' }]
      end

      it 'raises an error' do
        expect { load_subject }.to raise_error(ActiveModel::UnknownAttributeError)
      end
    end
  end
end
