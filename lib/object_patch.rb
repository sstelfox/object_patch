

require "object_patch/exceptions"
require "object_patch/generator"
require "object_patch/operation_factory"
require "object_patch/operations"
require "object_patch/pointer"
require "object_patch/version"

module ObjectPatch # :nodoc:

  # Applies a series of patches to a source document. It is important to note
  # that this will return the changed document but will also modify the original
  # document that got passed in, using dup also isn't enough to prevent this
  # modification as any subvalues within a hash or an array will not by
  # duplicated. A deep duplication by marshalling the object, encoding and
  # decoding as JSON, or using a recursive function to duplicate all of an
  # object's contents would prevent your source from being modified.
  #
  # The JSON Patch RFC specifies that the original document shouldn't be
  # modified unless the whole series of patches is able to be applied
  # successfully.
  #
  # @param [Object] source The source document that will be modified.
  # @param [Array<Hash<String => String>>] patches An array of JSON patch
  #   operations that should be applied to the source document.
  # @return [Object] The modified source document.
  def apply(source, patches)
    patches.inject(source) do |src, patch|
      OperationFactory.build(patch).apply(src)
    end
  end

  # Proxies the generation of a new set of patches to the Generator.
  #
  # @see [Generator#generate]
  # @param [Object] source The source document
  # @param [Object] target The target document we'll generate the
  #   differences for.
  # @return [Array<Hash>]
  def generate(source, target)
  end

  module_function :apply, :generate
end
