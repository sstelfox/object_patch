
module ObjectPatch
  module Operations
    class Test
      def initialize(patch_hash)
        @path = ObjectPatch::Pointer.decode(patch_hash.fetch("path"))
        @value = patch_hash.fetch("value")
      end

      def apply(source_hash)
        recursive_test(source_hash, @path, @value)
      end

      def recursive_test(obj, path, test_value)
        raise ArgumentError unless key = path.shift
        key_type = obj.class
        key = key.to_i if key_type == Array

        raise ArgumentError if key_type == Array && obj.size >= key
        raise ArgumentError if key_type == Hash && !obj.keys.include?(key)

        if path.empty?
          raise ArgumentError unless obj[key] == test_value
          return
        else
          recursive_test(obj[key], path, test_value)
        end
      end
    end
  end
end

