
module ObjectPatch::Operations
  class Copy
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
      { 'op' => 'copy', 'from' => @from, 'path' => @path }
    end
  end
end

