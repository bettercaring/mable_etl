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

  context '#extract' do
    it 'extracts a file from local' do
      subject.extract
      expect(File).to exist('temp/test.csv')
      File.delete('temp/test.csv')
    end
  end
end
