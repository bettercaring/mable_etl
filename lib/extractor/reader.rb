# frozen_string_literal: true

require 'pry'
require 'csv'

module MableEtl
  class Reader
    # file_type, format & db model name
    # handle multiple file locations & formats
    def initialize(attribute)
      @attribute = attribute
    end

    def read_csv
      binding.pry
      CSV.read(File.path('test.csv'))
    end
  end
end
