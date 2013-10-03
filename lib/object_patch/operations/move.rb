
module ObjectPatch::Operations
  class Move
    def apply(target_doc)
      src_key = processed_from.last
      dst_key = processed_path.last

      src_obj = ObjectPatch::Pointer.eval(processed_from[0...-1], target_doc)
      dst_obj = ObjectPatch::Pointer.eval(processed_path[0...-1], target_doc)

      moved_value = ObjectPatch::Operations.rm_op(src_obj, src_key)
      ObjectPatch::Operations.add_op(dst_obj, dst_key, moved_value)

      target_doc
    end

    def initialize(patch_data)
      @from = patch_data.fetch('from')
      @path = patch_data.fetch('path')
    end

    def processed_from
      ObjectPatch::Pointer.parse(@from)
    end

    def processed_path
      ObjectPatch::Pointer.parse(@path)
    end

    def to_patch
      { 'op' => 'move', 'from' => @from, 'path' => @path }
    end
  end
end

