
module ObjectPatch::Operations
  class Copy
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

      if src.is_a?(Array)
        raise ObjectPatch::InvalidIndexError unless from_key =~ /\A\d+\Z/
        obj = src.fetch(from_key.to_i)
      else
        obj = src.fetch(from_key)
      end

      ObjectPatch::Operations.add_op(dest, key, obj)
    end
  end
end

