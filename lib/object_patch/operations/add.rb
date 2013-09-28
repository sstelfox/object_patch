
module ObjectPatch
  module Operations
    class Add
      def initialize(patch_hash)
        @path = ObjectPatch::Pointer.decode(patch_hash.fetch("path"))
        @value = patch_hash.fetch("value", nil)
      end

      def apply(source_hash)
        recursive_set(source_hash, @path, @value)
      end

      def recursive_set(obj, path, new_value)
        if path.length > 1
          key = path.shift

          # If the object is nil, default to an empty array or a hash
          new_obj = new_obj || (key.is_a?(Fixnum) ? [] : {})

          obj[key] = recursive_set((new_obj[key] || {}), path, new_value)

        else
          obj[path.first] = new_value
        end

        obj
      end
    end
  end
end

