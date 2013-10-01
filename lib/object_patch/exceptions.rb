
module ObjectPatch
  BaseException = Class.new(StandardError)

  InvalidOperation = Class.new(BaseException)
  IndexError = Class.new(BaseException)
end
