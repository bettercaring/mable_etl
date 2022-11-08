# frozen_string_literal: true

require 'spec_helper'
require 'mable_etl/control'

RSpec.describe MableEtl::Control do
  subject(:control) { described_class.new(params) }
  let(:params) do
    {
      extractor_type: 'LocalExtractor',
      file_path: 'spec/fixtures/files/test.csv',
      transformer_types: ['CsvObjectTransformer', 'MapTransformer'],
      config_model_name: 'User',
      loader_type: 'ActiveRecordLoader'
    }
  end

  describe '#process' do
    it 'is successful' do
        binding.pry
#       subject.process
      expect(control.process).to eq(true)
    end
  end
end
