
module ObjectPatch::Operations

  # An implementation of the JSON patch test operation.
  class Test

    # A simple test to validate the value at the expected location matches the
    # value in the patch information. Will raise an error if the test fails.
    #
    # @param [Object] target_doc
    # @return [Object] Unmodified version of the document.
    def apply(target_doc)
      unless @value == ObjectPatch::Pointer.eval(processed_path, target_doc)
        raise ObjectPatch::FailedTestException.new(@value, @path)
      end

      target_doc
    end

    # Setup the test operation with any required arguments.
    #
    # @param [Hash] patch_data Parameters necessary to build the operation.
    # @option patch_data [String] path The location in the target document to
    #   test.
    # @return [void]
    def initialize(patch_data)
      @path = patch_data.fetch('path')
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
    # @return [Hash<String => String>] JSON patch test operation
    def to_patch
      { 'op' => 'test', 'path' => @path, 'value' => @value }
    end
  end
end

