# frozen_string_literal: true

require 'spec_helper'
require 'extractors/csv'

RSpec.describe MableEtl::Extractors::CSV do
  let(:subject) { described_class.new(file) }
  let(:file) { 'spec/fixtures/files/test.csv' }

  it 'reads a csv file' do
    subject.read
    expect(subject.read).to eq([{ 'name' => 'Mable', ' number' => '1' },
                                { 'name' => 'better_caring', ' number' => '2' }])
  end
end
