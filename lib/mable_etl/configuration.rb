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
    # - Database model name
    # - Database column names
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
    #   config.db_model_name = ''
    #   config.db_column_names = ''
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
    # MableEtl.configuration.db_model_name
    # MableEtl.configuration.db_column_names
    # ```
    # # Resetting configuration
    #
    # To reset, simply call `MableEtl.reset`.
    #
    attr_writer :aws_s3_region, :aws_access_key_id, :aws_secret_access_key, :db_model_name, :db_column_names

    def initialize
      @aws_s3_region = nil
      @aws_access_key_id = nil
      @aws_secret_access_key = nil
      @db_model_name = nil
      @db_column_names = nil
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

    def db_model_name
      unless @db_model_name
        raise MableEtl::Errors::Configuration,
              'MableEtl database model name missing! See the documentation for configuration settings.'
      end

      @db_model_name
    end

    def db_column_names
      unless @db_column_names
        raise MableEtl::Errors::Configuration,
              'MableEtl database column names missing! See the documentation for configuration settings.'
      end

      @db_column_names
    end
  end
end
