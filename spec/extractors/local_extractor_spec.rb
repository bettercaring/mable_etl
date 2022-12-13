# frozen_string_literal: true

require 'spec_helper'
require 'extractors/local_extractor'

RSpec.describe MableEtl::Extractors::LocalExtractor do
  let(:subject) { described_class.new(params) }
  let(:params) do
    {
      file_path: file_path
    }
  end

  let(:file_path) { 'spec/fixtures/files/test.csv' }

  describe '#initialize' do
    context 'with valid params' do
      it 'does not raise error' do
        expect { subject }.not_to raise_error
      end
    end

    context 'with invalid params' do
      context 'when config_model_name is nil' do
        let(:file_path) { nil }

        it 'raises error' do
          expect do
            subject
          end.to raise_error(MableEtl::Errors::Extractors::LocalExtractor, { file_path: ['must be a string'] }.to_s)
        end
      end

      context "when file doesn't exist" do
        let(:file_path) { '/bad_file_path/file.csv' }

        it 'raises error' do
          expect do
            subject
          end.to raise_error(MableEtl::Errors::Extractors::LocalExtractor, { file_path: ['file must exist'] }.to_s)
        end
      end
    end
  end

  describe '#extract' do
    let(:extract_result) { instance_double(MableEtl::Extractors::ExtractorResult) }

    context 'is successful' do
      before do
        allow(MableEtl::Extractors::ExtractorResult).to receive(:new).with(
          message: "Extract success: local file #{file_path} extracted to temp folder", mable_etl_file_path: 'temp/test.csv'
        ).and_return(extract_result)

        subject.extract
      end

      it 'returns a result object' do
        expect(subject.extract).to eq(extract_result)
      end

      it 'extracts a file from local' do
        expect(File).to exist('temp/test.csv')
        File.delete('temp/test.csv')
      end
    end
  end
end
