
module ObjectPatch::Operations

  # A representation of a JSON pointer move operation.
  class Move

    # Apply this operation to the provided document and return the updated
    # document. Please note that the changes will be reflected not only in the
    # returned value but the original document that was passed in as well.
    #
    # @param [Object] target_doc The document that will be modified by this
    #   patch.
    # @return [Object] The modified document
    def apply(target_doc)
      src_key = processed_from.last
      dst_key = processed_path.last

      src_obj = ObjectPatch::Pointer.eval(processed_from[0...-1], target_doc)
      dst_obj = ObjectPatch::Pointer.eval(processed_path[0...-1], target_doc)

      moved_value = ObjectPatch::Operations.rm_op(src_obj, src_key)
      ObjectPatch::Operations.add_op(dst_obj, dst_key, moved_value)

      target_doc
    end

    # Setup the replace operation with any required arguments.
    #
    # @param [Hash] patch_data Parameters necessary to build the operation.
    # @option patch_data [String] path The location in the target document to
    #   place moved data.
    # @option patch_data [String] from The location that will be moved to a new
    #   path.
    # @return [void]
    def initialize(patch_data)
      @from = patch_data.fetch('from')
      @path = patch_data.fetch('path')
    end

    # Returns the from field after being expanded by the JSON pointer semantics.
    #
    # @return [Array<String>] Expanded pointer path
    def processed_from
      ObjectPatch::Pointer.parse(@from)
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
    # @return [Hash<String => String>] JSON patch move operation
    def to_patch
      { 'op' => 'move', 'from' => @from, 'path' => @path }
    end
  end
end

