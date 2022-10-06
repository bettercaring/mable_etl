# frozen_string_literal: true

require 'pry'
# require_relative 'mable_etl/version'

class Extractor
  def csv
    binding.pry
    CSV.generate do |csv|
      csv << [:blue, 1]
      csv << [:white, 2]
      csv << [:black_and_white, 3]
    end
#     require "pry"
    puts "hello"
  end

  def read
  end
end
