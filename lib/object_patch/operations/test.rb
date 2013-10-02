
module ObjectPatch::Operations
  class Test
    def initialize(patch_data)
      @patch_data = patch_data
    end

    # A simple test to validate the value at the expected location matches the
    # value in the patch information.
    def apply(target_doc)
      expected = ObjectPatch::Pointer.eval(ObjectPatch::Pointer.parse(@patch_data['path']), target_doc)

      unless expected == @patch_data['value']
        raise ObjectPatch::FailedTestException.new(@patch_data['value'], @patch_data['path'])
      end
    end
  end
end

