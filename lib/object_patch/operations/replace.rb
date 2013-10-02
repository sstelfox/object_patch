
module ObjectPatch::Operations
  class Replace
    def initialize(patch_data)
      @patch_data = patch_data
    end

    def apply(target_doc)
      list = ObjectPatch::Pointer.parse(@patch_data['path'])
      key  = list.pop
      obj  = ObjectPatch::Pointer.eval(list, target_doc)

      if obj.is_a?(Array)
        raise ObjectPatch::InvalidIndexError unless key =~ /\A\d+\Z/
        obj[key.to_i] = @patch_data['value']
      else
        obj[key] = @patch_data['value']
      end
    end
  end
end

