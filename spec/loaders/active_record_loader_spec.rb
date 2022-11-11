# frozen_string_literal: true

require 'spec_helper'
require 'mable_etl/errors/loaders/active_record_loader'
require 'loaders/active_record_loader'

RSpec.describe MableEtl::Loaders::ActiveRecordLoader do
  subject(:active_record_loader) { described_class.new(params) }
  let(:params) do
    {
      config_model_name: 'User',
      mable_etl_data:
    }
  end
  let(:mable_etl_data) do
    [{ id: 1, name: 'name', email: 'chicken@gmail.com' },
     { id: 1, name: 'gerald', email: 'chicken@gmail.com' },
     { id: 2, name: 'hello', email: 'hello@gmail.com' }]
  end

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
    before do
      active_record_loader.load
    end
    it 'adds the data to the table' do
      expect(User.count).to eq(2)
    end

    it 'does not add duplicate data to the table' do
      expect(User.pluck(:id)).to eq([1, 2])
    end

    context 'is unsuccessful' do
      # let(:mable_etl_data) do
      #   [{}]
      # end
      it 'raises an error' do
        binding.pry
        expect { active_record_loader.load }.to raise_error(MableEtl::Errors::Loaders::ActiveRecordLoader)
      end
    end
  end
end
