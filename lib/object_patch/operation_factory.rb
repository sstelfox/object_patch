
module ObjectPatch
  module OperationFactory
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

