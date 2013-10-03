
module ObjectPatch::Operations
  class Add
    def initialize(patch_data)
      @patch_data = patch_data
    end

    def apply(target_doc)
      path      = ObjectPatch::Pointer.parse(@patch_data['path'])
      key       = path.pop
      new_value = @patch_data['value']
      
      dest_obj  = ObjectPatch::Pointer.eval(path, target_doc)
      raise(MissingTargetException, @patch_data['path']) unless dest_obj

      if key
        ObjectPatch::Operations.add_op(dest_obj, key, new_value)
      else
        dest_obj.replace(new_value)
      end

      target_doc
    end
  end
end

