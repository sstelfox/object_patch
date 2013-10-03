
module ObjectPatch

  # A factory module used to build the appropriate operation objects.
  module OperationFactory

    # Build an operation object that matches the operation type and makes the
    # appropriate information available to them.
    #
    # @param [Hash] patch
    # @return [Object] One of the operations classes.
    def build(patch)
      operations = ObjectPatch::Operations.constants.map { |c| c.to_s.downcase }

      unless operations.include?(patch['op'])
        raise InvalidOperation, "Invalid operation: `#{patch['op']}`" 
      end

      Operations.const_get(patch['op'].capitalize.to_sym).new(patch)
    end

    module_function :build
  end
end

