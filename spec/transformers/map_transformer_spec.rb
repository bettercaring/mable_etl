require 'csv'
require 'spec_helper'
require 'transformers/map_transformer'
require 'mable_etl/errors/transformers/map_transformer'

RSpec.describe MableEtl::Transformers::MapTransformer do
  subject(:map_transformer) { described_class.new(params) }
  let(:params) do
    {
      data: ::CSV.parse(File.read('spec/fixtures/files/test.csv'), headers: true)
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
          params[:data] = nil
        end
        it 'raises error' do
          expect { map_transformer }.to raise_error(MableEtl::Errors::Transformers::MapTransformer, { data: ['must be filled'] }.to_s)
        end
      end
    end
  end

  describe '#transform' do
    it 'maps the data to a hash' do
      expect(map_transformer.transform).to eq([{ 'name' => 'Mable', ' number' => '1' },
                                               { 'name' => 'better_caring', ' number' => '2' }])
    end
  end
end
