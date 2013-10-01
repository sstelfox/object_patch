
module ObjectPatch
  module Operations
    class Replace
      def initialize(patch_hash)
        @path = ObjectPatch::Pointer.decode(patch_hash.fetch("path"))
        @value = patch_hash.fetch("value")
      end

      def apply(source_hash)
        recursive_replace(source_hash, @path, @value)
      end

      def recursive_replace(obj, path, new_value)
        raise ArgumentError unless key = path.shift
        key_type = obj.class
        key = key.to_i if key_type == Array

        raise ArgumentError if key_type == Array && obj.size >= key
        raise ArgumentError if key_type == Hash && !obj.keys.include?(key)

        if path.empty?
          obj[key] = new_value
        else
          obj[key] = recursive_replace(obj[key], path, new_value)
        end

        obj
      end
    end
  end
end

