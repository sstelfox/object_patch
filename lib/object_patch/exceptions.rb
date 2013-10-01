
module ObjectPatch
  BaseException = Class.new(StandardError)

  IndexError          = Class.new(BaseException)
  InvalidOperation    = Class.new(BaseException)
  MissingKeyError     = Class.new(BaseException)
  TestOperationFailed = Class.new(BaseException)
end
