# frozen_string_literal: true

require 'spec_helper'
require 'loaders/active_record_loader'

RSpec.describe MableEtl::Loaders::ActiveRecordLoader do
  subject(:active_record_loader) { described_class.new(params) }
  let(:params) do
    {
      config_table_name: User,
      data:
      [{ id: 1, name: 'name', email: 'chicken@gmail.com' },
       { id: 1, name: 'gerald', email: 'chicken@gmail.com' },
       { id: 2, name: 'hello', email: 'hello@gmail.com' }]
    }
  end

  describe '#load' do
    it 'adds the data to the table' do
      active_record_loader.load
      expect(User.count).to eq(2)
    end
  end
end
