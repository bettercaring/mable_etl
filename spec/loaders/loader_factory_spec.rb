# require 'spec_helper'
# require 'loaders/loader_factory'

# RSpec.describe MableEtl::Loaders::LoaderFactory do
#   subject(:loader_factory) { described_class.for(data, config_loader, loader_type) }
#   let(:config_loader) { User }
#   let(:loader_type) { 'ActiveRecord' }
#   let(:data) do
#     [{ id: 1, name: 'name', email: 'chicken@gmail.com' },
#      { id: 1, name: 'gerald', email: 'chicken@gmail.com' },
#      { id: 2, name: 'hello', email: 'hello@gmail.com' }]
#   end

#   describe '#for' do
#     it 'adds the data to the table' do
#        loader_factory
#     end
#   end
# end
