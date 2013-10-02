
module ObjectPatch
  module Operations
    class Add
      def initialize(patch_hash)
        @path = ObjectPatch::Pointer.parse(patch_hash.fetch("path"))
        @value = patch_hash.fetch("value", nil)
      end

      def apply(source_hash)
        recursive_set(source_hash, @path, @value)
      end

      def recursive_set(obj, path, new_value)
        raise ArgumentError unless key = path.shift
        key_type = obj.class
        key = -1 if key == "-"

        raise IndexError if key_type == Array && obj.size >= key.to_i
        raise MissingTargetError if key_type == Hash && !obj.keys.include?(key)

        if path.empty?
          obj.insert(key, new_value)
        else
          recursive_set(obj[key], path, test_value)
        end

        obj
      end
    end
  end
end

