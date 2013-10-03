
module ObjectPatch::Operations
  class Test
    def initialize(patch_data)
      @path = patch_data.fetch('path')
      @value = patch_data.fetch('value')
    end

    # A simple test to validate the value at the expected location matches the
    # value in the patch information.
    def apply(target_doc)
      unless @value == ObjectPatch::Pointer.eval(processed_path, target_doc)
        raise ObjectPatch::FailedTestException.new(@value, @path)
      end

      target_doc
    end

    def processed_path
      ObjectPatch::Pointer.parse(@path)
    end

    def to_patch
      { 'op' => 'test', 'path' => @path, 'value' => @value }
    end
  end
end

