
module ObjectPatch
  BaseException = Class.new(StandardError)

  InvalidIndexError               = Class.new(BaseException)
  InvalidOperation                = Class.new(BaseException)
  MissingTargetException          = Class.new(BaseException)
  ObjectOperationOnArrayException = Class.new(BaseException)
  OutOfBoundsException            = Class.new(BaseException)
  TraverseScalarException         = Class.new(BaseException)

  class FailedTestException < BaseException
    attr_accessor :path, :value

    def initialize(path, value)
      super("Expected #{value} at #{path}")
      @path, @value = path, value
    end
  end
end
