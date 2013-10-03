
module ObjectPatch::Operations
  # A representation of a JSON pointer remove operation.
  class Remove
    # Apply this operation to the provided document and return the updated
    # document. Please note that the changes will be reflected not only in the
    # returned value but the original document that was passed in as well.
    #
    # @param [Object] target_doc The document that will be modified by this
    #   patch.
    # @return [Object] The modified document
    def apply(target_doc)
      key = processed_path.last
      inner_obj = ObjectPatch::Pointer.eval(processed_path[0...-1], target_doc)

      ObjectPatch::Operations.rm_op(inner_obj, key)

      target_doc
    end

    # Setup the remove operation with any required arguments.
    #
    # @param [Hash] patch_data Parameters necessary to build the operation.
    # @option patch_data [String] path The location in the target document to
    #   remove.
    # @return [void]
    def initialize(patch_data)
      @path = patch_data.fetch('path')
    end

    # Returns the path after being expanded by the JSON pointer semantics.
    #
    # @return [Array<String>] Expanded pointer path
    def processed_path
      ObjectPatch::Pointer.parse(@path)
    end

    # Covert this operation to a format that can be built into a full on JSON
    # patch.
    #
    # @return [Hash<String => String>] JSON Remove operation
    def to_patch
      { 'op' => 'remove', 'path' => @path }
    end
  end
end

