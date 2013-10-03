
module ObjectPatch
  # This is a parent exception for anything that is going to get raised by this
  # gem, allowing users of this code to catch all the subclasses.
  BaseException = Class.new(StandardError)

  # Raised when the index value that was attempted to be accessed isn't a
  # numeric identifier or '-' (the special index value defined in JSON Pointer).
  InvalidIndexError = Class.new(BaseException)

  # An exception that gets raised when a patch contains an invalid operation.
  InvalidOperation = Class.new(BaseException)

  # An exception that gets raised when an operation takes place on a missing
  # hash key, or a missing hash key is somewhere along the path.
  MissingTargetException = Class.new(BaseException)

  # Raised when a non-integer value is attempted to be used to access some part
  # of an array.
  ObjectOperationOnArrayException = Class.new(BaseException)

  # When an integer value outside the available range of an array is used to
  # access an array this will get raised.
  OutOfBoundsException = Class.new(BaseException)

  # When the path provided attempts to cross a scalar value, this exception will
  # be raised.
  TraverseScalarException = Class.new(BaseException)

  # An exception that will get raised when a test operation fails after being
  # applied to a document.
  #
  # @attr [String] path A JSON pointer string representing the location to be
  #   checked.
  # @attr [Object] value The value that failed the comparison check.
  class FailedTestException < BaseException
    attr_accessor :path, :value

    # Formats the exception message with the relevant information before
    # actually raising the error.
    #
    # @param [String] path
    # @param [Object] value
    # @return [void]
    def initialize(path, value)
      super("Expected #{value} at #{path}")
      @path, @value = path, value
    end
  end
end

