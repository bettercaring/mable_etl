# frozen_string_literal: true

require 'spec_helper'
require 'transformers/csv_object_transformer'
require 'mable_etl/errors/transformers/csv_object_transformer'

RSpec.describe MableEtl::Transformers::CsvObjectTransformer do
  subject(:csv_object_transformer) { described_class.new(params) }

  let(:params) do
    {
      mable_etl_file_path: mable_etl_file_path
    }
  end
  let(:mable_etl_file_path) { 'spec/fixtures/files/test.csv' }

  describe '#initialize' do
    context 'with valid params' do
      it 'does not raise error' do
        expect { csv_object_transformer }.not_to raise_error
      end
    end

    context 'with invalid params' do
      context 'when data is nil' do
        before do
          params[:mable_etl_file_path] = nil
        end

        it 'raises error' do
          expect do
            csv_object_transformer
          end.to raise_error(MableEtl::Errors::Transformers::CsvObjectTransformer,
                             { mable_etl_file_path: ['must be a string'] }.to_s)
        end
      end

      context "when s3_path doesn't exist" do
        let(:mable_etl_file_path) { '/bad_file_path/file.csv' }

        it 'raises error' do
          expect do
            csv_object_transformer
          end.to raise_error(MableEtl::Errors::Transformers::CsvObjectTransformer,
                             { mable_etl_file_path: ['file must exist'] }.to_s)
        end
      end
    end
  end

  describe '#transform' do
    let(:csv_object_result) { CSV.parse(File.read(params[:mable_etl_file_path]), headers: true) }
    let(:transform_result) { instance_double(MableEtl::Transformers::TransformerResult) }

    context 'when successful' do
      before do
        allow(MableEtl::Transformers::TransformerResult).to receive(:new).with(
          message: "Transformer success: #{mable_etl_file_path} transformed to CSV object", mable_etl_data: csv_object_result
        ).and_return(transform_result)

        csv_object_transformer.transform
      end

      it 'returns a result object' do
        expect(csv_object_transformer.transform).to eq(transform_result)
      end
    end
  end
end
