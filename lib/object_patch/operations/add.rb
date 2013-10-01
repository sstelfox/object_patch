
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

        raise ArgumentError if key_type == Array && key.to_s == "-" || obj.size >= key
        raise ArgumentError if key_type == Hash && !obj.keys.include?(key)

        if path.empty?
          if key == "-"
            obj.push(new_value)
          else
            obj[key] = new_value
          end
        else
          recursive_set(obj[key], path, test_value)
        end

        obj
      end
    end
  end
end

