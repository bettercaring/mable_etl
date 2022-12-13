# frozen_string_literal: true

require_relative 'mable_etl/version'
require 'mable_etl/configuration'
require 'mable_etl/control'
require 'extractors/local_extractor'
require 'extractors/S3_extractor'
require 'extractors/extractor_factory'
require 'transformers/transformer_factory'
require 'transformers/csv_object_transformer'
require 'transformers/map_transformer'
require 'loaders/loader_factory'
require 'loaders/active_record_loader'
require 'loaders/loader_result'

Dir.glob("#{File.dirname(__dir__)}/contracts/**/*.rb").sort.each { |file| require file }

module MableEtl
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Error < StandardError; end
  # Your code goes here...
end
