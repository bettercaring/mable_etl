require 'csv'
require 'spec_helper'
require 'transformers/downcase_transformer'
require 'mable_etl/errors/transformers/downcase_transformer'

RSpec.describe MableEtl::Transformers::DowncaseTransformer do
  subject(:downcase_transformer) { described_class.new(params) }
  let(:params) do
    {
      mable_etl_data: ::CSV.parse(File.read('spec/fixtures/files/test.csv'), headers: true),
      downcase_columns: ['name']
    }
  end

  describe '#initialize' do
    context 'with valid params' do
      it 'does not raise error' do
        expect { downcase_transformer }.not_to raise_error
      end
    end

    context 'with invalid params' do
      context 'when data is nil' do
        before do
          params[:mable_etl_data] = nil
        end

        it 'raises error' do
        end
      end
    end
  end

  describe '#transform' do
    context 'is successful' do
      let(:downcased_result) do
        [{ 'name' => 'MaBble', 'id' => '1', 'email' => 'DJDJSJKKJAKJKJDKJDKJSjjkkk@test.com'},
         { 'name' => 'BetTer_caRing', 'id' => '2' }]
      end

      let(:transformed_result) do
        [{ 'name' => 'mable', 'id' => '1', 'email' => 'DJDJSJKKJAKJKJDKJDKJSjjkkk@test.com' },
         { 'name' => 'better_caring', 'id' => '2' }]
      end

      it 'downcases the data' do
#        expect(downcase_transformer.transform.result).to eq(transform_result)
      end
    end
  end
end
