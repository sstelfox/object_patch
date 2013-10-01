
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
        return obj if path.nil? || path.empty?

        # Grab our key off the stack
        key = path.shift

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

