require 'pry'
require 'mable_etl/errors/configuration'

module MableEtl
  class Configuration
    # Adds global configuration settings to the gem, including:
    #
    # * `config.aws_s3_region` - your AWS S3 region
    # * `config.aws_access_key_id` - your AWS access key id
    # * `config.aws_secret_access_key` - your AWS secret access key
    #
    # # Required fields
    #
    # The following fields are *required* to use the gem:
    #
    # - AWS S3 Region
    # - AWS Access Key id
    # - AWS secret access key
    #
    # The gem will raise a `Errors::Configuration` if you fail to provide these keys.
    #
    # # Configuring your gem
    #
    # ```
    # MableEtl.configure do |config|
    #   config.aws_s3_region = ''
    #   config.aws_access_key_id = ''
    #   config.aws_secret_access_key = ''
    # end
    # ```
    #
    # # Accessing configuration settings
    #
    # All settings are available on the `MableEtl.configuration` object:
    #
    # ```
    # MableEtl.configuration.aws_s3_region
    # MableEtl.configuration.aws_access_key_id
    # MableEtl.configuration.aws_secret_access_key
    # ```
    # # Resetting configuration
    #
    # To reset, simply call `MableEtl.reset`.
    #
    attr_writer :aws_s3_region, :aws_access_key_id, :aws_secret_access_key

    def initialize
      @aws_s3_region = nil
      @aws_access_key_id = nil
      @aws_secret_access_key = nil
    end

    def aws_s3_region
      unless @aws_s3_region
        raise MableEtl::Errors::Configuration,
              'MableEtl S3 region missing! See the documentation for configuration settings.'
      end

      @aws_s3_region
    end

    def aws_access_key_id
      unless @aws_access_key_id
        raise MableEtl::Errors::Configuration,
              'MableEtl access key missing! See the documentation for configuration settings.'
      end

      @aws_access_key_id
    end

    def aws_secret_access_key
      unless @aws_secret_access_key
        raise MableEtl::Errors::Configuration,
              'MableEtl secret key missing! See the documentation for configuration settings.'
      end

      @aws_secret_access_key
    end
  end
end
