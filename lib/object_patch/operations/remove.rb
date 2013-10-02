
module ObjectPatch::Operations
  class Remove
    def initialize(patch_data)
      @patch_data = patch_data
    end

    def apply(target_doc)
      list = ObjectPatch::Pointer.parse(@patch_data['path'])
      key  = list.pop
      obj  = ObjectPatch::Pointer.eval(list, target_doc)

      ObjectPatch::Operations.rm_op(obj, key)
    end
  end
end

