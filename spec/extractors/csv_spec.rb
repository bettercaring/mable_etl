# frozen_string_literal: true

require 'spec_helper'
require 'extractors/csv'

RSpec.describe MableEtl::Extractors::CSV do
  let(:subject) { described_class.new(params) }
  let(:params) do
    {
      file_path: 'spec/fixtures/files/test.csv'
    }
  end

  describe '#initialize' do
    context 'with valid params' do
      it 'does not raise error' do
        expect { subject }.not_to raise_error
      end
    end

    context 'with invalid params' do
      context 'when config_model_name is nil' do
        before do
          params[:file_path] = nil
        end
        it 'raises error' do
          expect { subject }.to raise_error(MableEtl::Errors::Extractors::CSV)
        end
      end
    end
  end

  it 'extract a csv file' do
    subject.extract
    expect(subject.extract).to eq([{ 'name' => 'Mable', ' number' => '1' },
                                   { 'name' => 'better_caring', ' number' => '2' }])
  end
end
