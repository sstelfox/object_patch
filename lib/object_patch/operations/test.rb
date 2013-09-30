
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
        if path.nil? || path.empty?
          raise ArgumentError unless (obj == test_value)
          return
        end

        # Grab our key off the stack
        key = path.shift
        raise ArgumentError if key.nil?

        recursive_test(obj[key], path, test_value)
      end
    end
  end
end

