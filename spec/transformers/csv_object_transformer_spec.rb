require 'spec_helper'
require 'transformers/csv_object_transformer'
require 'mable_etl/errors/transformers/csv_object_transformer'

RSpec.describe MableEtl::Transformers::CsvObjectTransformer do
  subject(:csv_object_transformer) { described_class.new(params) }
  let(:params) do
    {
      file_path: file_path
    }
  end
  let(:file_path) { 'spec/fixtures/files/test.csv' }

  describe '#initialize' do
    context 'with valid params' do
      it 'does not raise error' do
        expect { csv_object_transformer }.not_to raise_error
      end
    end

    context 'with invalid params' do
      context 'when data is nil' do
        before do
          params[:file_path] = nil
        end
        it 'raises error' do
          expect { csv_object_transformer }.to raise_error(MableEtl::Errors::Transformers::CsvObjectTransformer, { file_path: ['must be a string'] }.to_s)
        end
      end

      context "when s3_path doesn't exist" do
        let(:file_path) { '/bad_file_path/file.csv' }

        it 'raises error' do  
          expect { csv_object_transformer }.to raise_error(MableEtl::Errors::Transformers::CsvObjectTransformer, { file_path: ['file must exist'] }.to_s)
        end
      end
    end
  end

  describe '#transform' do
    it 'changes csv file to csv object' do
      expect(csv_object_transformer.transform).to eq(CSV.parse(File.read(params[:file_path]), headers: true))
    end
  end
end
