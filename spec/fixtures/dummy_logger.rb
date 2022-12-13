# frozen_string_literal: true

class DummyLogger
  def info(message)
    message
  end

  def error(message)
    message
  end
end
