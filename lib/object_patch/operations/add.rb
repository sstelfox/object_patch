
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
        raise ArgumentError unless key = path.shift
        key_type = obj.class
        key = key.to_i if key_type == Array && key != "-"

        raise ArgumentError if key_type == Array && key == "-" || obj.size >= key
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

        # Ensure we have an actual object to set the value on
        key_type = (key == "-" || key.is_a?(Fixnum)) ? Array : Hash

        if key == "-"
          # Hyphen is a special case where we append to the array
          obj = key_type.new if obj.nil?
          obj.push(recursive_set(obj, path, new_value))
        else
          obj = key_type.new if obj.nil?

          recursion_result = recursive_set(obj[key], path, new_value)

          obj[key] = recursion_result if key_type == Hash
          obj.insert(key, recursion_result) if key_type == Array
        end

        obj
      end
    end
  end
end

