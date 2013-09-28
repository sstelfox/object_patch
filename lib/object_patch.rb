
require "object_patch/operations/add"
require "object_patch/operations/copy"
require "object_patch/operations/move"
require "object_patch/operations/remove"
require "object_patch/operations/replace"
require "object_patch/operations/test"
require "object_patch/operation_factory"
require "object_patch/version"

module ObjectPatch
  def apply(source, patches)
    patches.inject(source) do |s, p|
      OperationFactory.process(p).apply(s)
    end
  end

  module_function :apply
end
