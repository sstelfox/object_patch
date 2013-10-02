

require "object_patch/exceptions"
require "object_patch/operation_factory"
require "object_patch/operations"
require "object_patch/pointer"
require "object_patch/version"

module ObjectPatch
  def apply(source, patches)
    patches.each_with_object(source) do |patch, doc|
      OperationFactory.build(patch).apply(doc)
    end
  end

  def generate(source, target_hash)
  end

  module_function :apply
end
