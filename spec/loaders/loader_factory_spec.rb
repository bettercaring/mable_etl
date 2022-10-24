require 'spec_helper'
require 'loaders/loader_factory'

RSpec.describe MableEtl::Loaders::LoaderFactory do
  subject(:loader_factory) { described_class.for(data, config_loader, loader_type) }
  let(:config_loader) { User }
  let(:loader_type) { 'ActiveRecordLoader' }
  let(:data) do
    [{ id: 1, name: 'name', email: 'chicken@gmail.com' },
     { id: 1, name: 'gerald', email: 'chicken@gmail.com' },
     { id: 2, name: 'hello', email: 'hello@gmail.com' }]
  end
  let(:active_record_loader) { instance_double(MableEtl::Loaders::ActiveRecordLoader) }
  let(:load_result) { true }

  before do
    allow(MableEtl::Loaders::ActiveRecordLoader).to receive(:new).and_return(active_record_loader)
    allow(active_record_loader).to receive(:load).and_return(load_result)
  end

  describe 'loader factory' do
    it 'sends data to the correct loader' do
      expect(loader_factory).to eq(load_result)
    end
  end
end
