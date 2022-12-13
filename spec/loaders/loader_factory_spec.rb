# frozen_string_literal: true

require 'spec_helper'
require 'loaders/loader_factory'

RSpec.describe MableEtl::Loaders::LoaderFactory do
  subject(:loader_factory) { described_class.for(params) }

  let(:params) do
    {
      config_loader: User,
      loader_type: 'ActiveRecordLoader',
      data:
      [{ id: 1, name: 'name', email: 'chicken@gmail.com' },
       { id: 1, name: 'gerald', email: 'chicken@gmail.com' },
       { id: 2, name: 'hello', email: 'hello@gmail.com' }]
    }
  end

  let(:active_record_loader) { instance_double(MableEtl::Loaders::ActiveRecordLoader) }

  before do
    allow(MableEtl::Loaders::ActiveRecordLoader).to receive(:new).and_return(active_record_loader)
  end

  describe 'loader factory' do
    it 'sends data to the correct loader' do
      expect(loader_factory).to eq(active_record_loader)
    end

    context 'error' do
      before do
        params[:loader_type] = nil
      end

      it 'raises error when loader_type nil' do
        expect do
          loader_factory
        end.to raise_error(MableEtl::Errors::Loaders::LoaderFactory, { loader_type: ['must be filled'] }.to_s)
      end
    end
  end
end
