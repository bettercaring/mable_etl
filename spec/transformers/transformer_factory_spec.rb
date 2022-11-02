require 'spec_helper'
require 'transformers/transformer_factory'

RSpec.describe MableEtl::Transformers::TransformerFactory do
  subject(:transformer_factory) { described_class.for(params) }
  let(:params) do
    {
      transformer_type: 'MapTransformer',
      data:
      [{ id: 1, name: 'name', email: 'chicken@gmail.com' },
       { id: 1, name: 'gerald', email: 'chicken@gmail.com' },
       { id: 2, name: 'hello', email: 'hello@gmail.com' }]
    }
  end

  let(:map_transformer) { instance_double(MableEtl::Transformers::MapTransformer) }
  let(:transformer_result) { true }

  before do
    allow(MableEtl::Transformers::MapTransformer).to receive(:new).and_return(map_transformer)
    allow(map_transformer).to receive(:transform).and_return(transformer_result)
  end

  describe 'transformer factory' do
    it 'sends data to the correct transformer' do
      expect(transformer_factory).to eq(transformer_result)
    end

    context 'error' do
      before do
        params[:transformer_type] = nil
      end
      it 'raises error when transformer_type nil' do
        expect { transformer_factory }.to raise_error(MableEtl::Errors::Transformers::TransformerFactory, { transformer_type: ["must be filled"] }.to_s)
      end
    end
  end
end
