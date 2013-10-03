
module ObjectPatch::Operations
  class Remove
    def initialize(patch_data)
      @path = patch_data.fetch('path')
    end

    def apply(target_doc)
      key = processed_path.last
      inner_obj = ObjectPatch::Pointer.eval(processed_path[0...-1], target_doc)

      ObjectPatch::Operations.rm_op(inner_obj, key)

      target_doc
    end

    def processed_path
      ObjectPatch::Pointer.parse(@path)
    end

    def to_patch
      { 'op' => 'remove', 'path' => @path }
    end
  end
end

