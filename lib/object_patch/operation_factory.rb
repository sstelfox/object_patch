
module ObjectPatch
  module OperationFactory
    def process(operation)
      const_spot = operation.delete("op").capitalize.to_sym
      ObjectPatch::Operations.const_get(const_spot).new(operation)
    end

    module_function :process
  end
end

