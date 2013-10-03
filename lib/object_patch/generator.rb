
module ObjectPatch

  # This module handles the generation of patches between two objects.
  module Generator

    # Generate a series of patch operations that describe the changes from the
    # source object to the target object.
    #
    # @todo This doesn't do anything yet...
    # @param [Object] source The source document
    # @param [Object] target The target document we'll generate the
    #   differences for.
    # @return [Array<Hash>]
    def generate(source, target)
    end

    module_function :generate
  end
end
