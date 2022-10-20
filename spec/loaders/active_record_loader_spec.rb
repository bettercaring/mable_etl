# frozen_string_literal: true

require 'spec_helper'
require 'loaders/table_loader'

RSpec.describe MableEtl::Loaders::ActiveRecordLoader do
  subject(:active_record_loader) { described_class.new(package_config, data) }
  let(:table_name) { User }
  let!(:number) { table_name.count + 2 }
  let(:data) do
    [{ id: table_name.last.id + 1, name: 'name', email: 'chicken@gmail.com' },
     { id: table_name.last.id + 1, name: 'gerald', email: 'chicken@gmail.com' },
     { id: table_name.last.id + 2, name: 'hello', email: 'hello@gmail.com' }]
  end

  let(:package_config) { { name: 'User' }

  describe '#load' do
    it 'adds the data to the table' do
      active_record_loader.load
      expect(User.count).to eq(number)
    end
  end
end
