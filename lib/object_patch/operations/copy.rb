
module ObjectPatch::Operations

  # A representation of a JSON pointer copy operation.
  class Copy

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

      if src_obj.is_a?(Array)
        raise ObjectPatch::InvalidIndexError unless src_key =~ /\A\d+\Z/
        copied_obj = src_obj.fetch(src_key.to_i)
      else
        copied_obj = src_obj.fetch(src_key)
      end

      ObjectPatch::Operations.add_op(dst_obj, dst_key, copied_obj)

      target_doc
    end

    # Setup the replace operation with any required arguments.
    #
    # @param [Hash] patch_data Parameters necessary to build the operation.
    # @option patch_data [String] path The location in the target document to
    #   duplicate the data to.
    # @option patch_data [String] from The source data that will be copied into
    #   the new location.
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
    # @return [Hash<String => String>] JSON patch copy operation
    def to_patch
      { 'op' => 'copy', 'from' => @from, 'path' => @path }
    end
  end
end

