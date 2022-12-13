# frozen_string_literal: true

require 'spec_helper'
require 'extractors/s3_extractor'

RSpec.describe MableEtl::Extractors::S3Extractor do
  subject(:s3_extractor) { described_class.new(params) }

  let(:params) do
    {
      s3_credentials: s3_credentials,
      s3_bucket: s3_bucket,
      s3_path: s3_path,
      tmp_folder_path: '/tmp'
    }
  end
  let(:s3_credentials) { { access_key_id: 'access_key', secret_access_key: 'secret_access_key' } }
  let(:s3_path) { 'spec/fixtures/files/test.csv' }
  let(:s3_bucket) { 'mable_bucket' }
  let(:s3) { Aws::S3::Client.new(stub_responses: true) }
  let(:s3_object) { { s3_object: 'object' } }

  before do
    allow(Aws::S3::Client).to receive(:new).and_return(s3)
    allow(s3).to receive(:get_object).and_return(s3_object)
  end

  describe '#initialize' do
    context 'with valid params' do
      it 'does not raise error' do
        expect { s3_extractor }.not_to raise_error
      end
    end

    context 'with invalid params' do
      context 'when s3_path is nil' do
        let(:s3_path) { nil }

        it 'raises error' do
          expect do
            s3_extractor
          end.to raise_error(MableEtl::Errors::Extractors::S3Extractor, { s3_path: ['must be a string'] }.to_s)
        end
      end

      context 'when s3_bucket is nil' do
        let(:s3_bucket) { nil }

        it 'raises error' do
          expect do
            s3_extractor
          end.to raise_error(MableEtl::Errors::Extractors::S3Extractor, { s3_bucket: ['must be a string'] }.to_s)
        end
      end

      context 'when s3_credentials is nil' do
        let(:s3_credentials) { nil }

        it 'raises error' do
          expect do
            s3_extractor
          end.to raise_error(MableEtl::Errors::Extractors::S3Extractor, { s3_credentials: ['must be a hash'] }.to_s)
        end
      end
    end
  end

  context 'when successful' do
    let(:extract_result) { instance_double(MableEtl::Extractors::ExtractorResult) }

    before do
      allow(MableEtl::Extractors::ExtractorResult).to receive(:new).with(
        message: "Extract success: S3 file #{s3_path} extracted successfully", mable_etl_file_path: '/tmp/mable_etl/test.csv'
      ).and_return(extract_result)

      allow(FileUtils).to receive(:mkdir_p).and_return(['/tmp/mable_etl'])

      s3_extractor.extract
    end

    it 'returns a result object' do
      expect(s3_extractor.extract).to eq(extract_result)
    end

    it 'creates etl folder' do
      expect(FileUtils).to have_received(:mkdir_p).with('/tmp/mable_etl')
    end
  end
end
