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
          expect { subject }.to raise_error(MableEtl::Errors::Extractors::LocalExtractor, { file_path: ['must be a string'] }.to_s )
        end
      end

      context "when file doesn't exist" do
        let(:file_path) { '/bad_file_path/file.csv' }

        it 'raises error' do
          expect { subject }.to raise_error(MableEtl::Errors::Extractors::LocalExtractor, { file_path: ['file must exist'] }.to_s )
        end
      end
    end
  end

  it 'extract a file from local' do
    subject.extract
    expect(subject.extract).to eq([{ 'name' => 'Mable', ' number' => '1' },
                                   { 'name' => 'better_caring', ' number' => '2' }])
  end
end
