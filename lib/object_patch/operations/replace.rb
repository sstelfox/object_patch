
module ObjectPatch::Operations

  # A representation of a JSON pointer replace operation.
  class Replace

    # Apply this operation to the provided document and return the updated
    # document. Please note that the changes will be reflected not only in the
    # returned value but the original document that was passed in as well.
    #
    # @param [Object] target_doc The document that will be modified by this
    #   patch.
    # @return [Object] The modified document
    def apply(target_doc)
      return @value if processed_path.empty?

      key = processed_path.last
      inner_obj = ObjectPatch::Pointer.eval(processed_path[0...-1], target_doc)

      if inner_obj.is_a?(Array)
        raise ObjectPatch::InvalidIndexError unless key =~ /\A\d+\Z/
        inner_obj[key.to_i] = @value
      else
        inner_obj[key] = @value
      end

      target_doc
    end

    # Setup the replace operation with any required arguments.
    #
    # @param [Hash] patch_data Parameters necessary to build the operation.
    # @option patch_data [String] path The location in the target document to
    #   replace with the provided data.
    # @option patch_data [String] value The value that should be written over
    #   whatever is at the provided path.
    # @return [void]
    def initialize(patch_data)
      @path  = patch_data.fetch('path')
      @value = patch_data.fetch('value')
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
    # @return [Hash<String => String>] JSON patch replace operation
    def to_patch
      { 'op' => 'replace', 'path' => @path, 'value' => @value }
    end
  end
end

