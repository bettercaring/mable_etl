# frozen_string_literal: true

require 'csv'
require 'spec_helper'
require 'transformers/map_transformer'
require 'mable_etl/errors/transformers/map_transformer'

RSpec.describe MableEtl::Transformers::MapTransformer do
  subject(:map_transformer) { described_class.new(params) }

  let(:params) do
    {
      mable_etl_data: ::CSV.parse(File.read('spec/fixtures/files/test.csv'), headers: true)
    }
  end

  describe '#initialize' do
    context 'with valid params' do
      it 'does not raise error' do
        expect { map_transformer }.not_to raise_error
      end
    end

    context 'with invalid params' do
      context 'when data is nil' do
        before do
          params[:mable_etl_data] = nil
        end

        it 'raises error' do
          expect do
            map_transformer
          end.to raise_error(MableEtl::Errors::Transformers::MapTransformer,
                             { mable_etl_data: ['must be filled'] }.to_s)
        end
      end
    end
  end

  describe '#transform' do
    context 'when successful' do
      let(:mapped_result) do
        [{ 'name' => 'Mable', 'id' => '1' },
         { 'name' => 'better_caring', 'id' => '2' }]
      end
      let(:transform_result) { instance_double(MableEtl::Transformers::TransformerResult) }

      before do
        allow(MableEtl::Transformers::TransformerResult).to receive(:new).with(
          message: 'Transformer success: data mapped to a hash', mable_etl_data: mapped_result
        ).and_return(transform_result)
      end

      it 'maps the data to a hash' do
        expect(map_transformer.transform).to eq(transform_result)
      end
    end
  end
end
