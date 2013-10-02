
module ObjectPatch
  BaseException = Class.new(StandardError)

  IndexError          = Class.new(BaseException)
  InvalidOperation    = Class.new(BaseException)
  MissingKeyError     = Class.new(BaseException)
  TestOperationFailed = Class.new(BaseException) do
    def initialize(path, value)
      super("Expected #{value} at #{path}")
    end
  end
end
