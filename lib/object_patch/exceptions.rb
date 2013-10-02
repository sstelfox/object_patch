
module ObjectPatch
  BaseException = Class.new(StandardError)

  IndexError                  = Class.new(BaseException)
  InvalidOperation            = Class.new(BaseException)
  MissingTargetError          = Class.new(BaseException)
  ObjectOperationOnArrayError = Class.new(BaseException)

  class TestOperationFailed < BaseException
    def initialize(path, value)
      super("Expected #{value} at #{path}")
    end
  end
end
