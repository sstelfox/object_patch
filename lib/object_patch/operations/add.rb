
module ObjectPatch::Operations
  class Add
    def initialize(patch_data)
      @path  = patch_data.fetch('path')
      @value = patch_data.fetch('value')
    end

    def apply(target_doc)
      key = processed_path.last
      inner_obj = ObjectPatch::Pointer.eval(processed_path[0...-1], target_doc)
      
      raise MissingTargetException, @path unless inner_obj

      if key
        ObjectPatch::Operations.add_op(inner_obj, key, @value)
      else
        inner_obj.replace(@value)
      end

      target_doc
    end

    def processed_path
      ObjectPatch::Pointer.parse(@path)
    end

    def to_patch
      { 'op' => 'replace', 'path' => @path, 'value' => @value }
    end
  end
end

