
module ObjectPatch::Operations
  class Move
    def initialize(patch_data)
      @patch_data = patch_data
    end

    def apply(target_doc)
      from     = ObjectPatch::Pointer.parse(@patch_data['from'])
      to       = ObjectPatch::Pointer.parse(@patch_data['path'])
      from_key = from.pop
      key      = to.pop
      src      = ObjectPatch::Pointer.eval(from, target_doc)
      dest     = ObjectPatch::Pointer.eval(to, target_doc)

      obj = ObjectPatch::Operations.rm_op(src, from_key)
      ObjectPatch::Operations.add_op(dest, key, obj)
    end
  end
end

