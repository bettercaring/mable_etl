# frozen_string_literal: true

RSpec.describe MableEtl::Reader do
  let(:subject) { described_class.new }

  it 'reads a csv file' do
    binding.pry
    expect(subject.reader).to eq([["Stacey ", "1"], ["Matt", "2"], ["Kim", "3"], ["Sameera", "4"]])
  end
end
