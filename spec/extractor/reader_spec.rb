# frozen_string_literal: true
require 'spec_helper'
require 'extractor/reader'

RSpec.describe MableEtl::Extractor::Reader do
  let(:subject) { described_class.new(file) }
  let(:file) { 'spec/fixtures/files/test.csv' }

  it 'reads a csv file' do
    expect(subject.read_csv).to eq([["Mable", "1"], ["better_caring", "2"]])
  end
end
