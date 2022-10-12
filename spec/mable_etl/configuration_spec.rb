# frozen_string_literal: true

require 'spec_helper'
require 'mable_etl/configuration'

RSpec.describe MableEtl::Configuration do
  before do
    MableEtl.configure do |config|
      config.aws_s3_region = 'region'
      config.aws_access_key_id = 'aws access key'
      config.aws_secret_access_key = 'aws secret'
    end
  end

  context 'with configuration block' do
    it 'returns the S3 region' do
      expect(MableEtl.configuration.aws_s3_region).to eq('region')
    end

    it 'returns the correct access key' do
      expect(MableEtl.configuration.aws_access_key_id).to eq('aws access key')
    end

    it 'returns the correct secret' do
      expect(MableEtl.configuration.aws_secret_access_key).to eq('aws secret')
    end
  end

  context 'without configuration block' do
    before do
      MableEtl.reset
    end

    it 'raises a configuration error for access_key' do
      expect { MableEtl.configuration.aws_s3_region }.to raise_error(MableEtl::Errors::Configuration)
    end

    it 'raises a configuration error for secret_key' do
      expect { MableEtl.configuration.aws_access_key_id }.to raise_error(MableEtl::Errors::Configuration)
    end

    it 'raises a configuration error for personal_key' do
      expect { MableEtl.configuration.aws_secret_access_key }.to raise_error(MableEtl::Errors::Configuration)
    end
  end
end
