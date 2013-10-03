
module ObjectPatch

  # A factory module used to build the appropriate operation objects.
  module OperationFactory

    # Build an operation object that matches the operation type and makes the
    # appropriate information available to them.
    #
    # @param [Hash] patch
    # @return [Object] One of the operations classes.
    def build(patch)
      op_const = patch['op'].capitalize.to_sym

      unless Operations.const_defined?(op_const)
        raise InvalidOperation, "Invalid operation: `#{patch['op']}`" 
      end

      Operations.const_get(op_const).new(patch)
    end

    module_function :build
  end
end

