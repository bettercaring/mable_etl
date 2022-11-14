# frozen_string_literal: true

require_relative 'mable_etl/version'
require 'mable_etl/configuration'
require 'mable_etl/control'
Dir.glob(File.dirname(__dir__) + "/contracts/**/*.rb").each { |file| require file }
Dir.glob(File.dirname(__dir__) + "/loaders/*.rb").each { |file| require file }
Dir.glob(File.dirname(__dir__) + "/transformers/*.rb").each { |file| require file }
Dir.glob(File.dirname(__dir__) + "/extractors/*.rb").each { |file| require file }

require 'pry'

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
