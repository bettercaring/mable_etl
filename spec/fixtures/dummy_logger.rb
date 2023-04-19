# frozen_string_literal: true

class DummyLogger
  def info(message)
    puts message
  end

  def error(message)
    puts message
  end
end
