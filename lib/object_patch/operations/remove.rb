
module ObjectPatch
  module Operations
    class Remove
      def initialize(patch_hash)
        @path = ObjectPatch::Pointer.decode(patch_hash.fetch("path"))
      end

      def apply(source_hash)
        recursive_remove(source_hash, @path)
      end

      def recursive_remove(obj, path)
        raise ArgumentError unless key = path.shift
        key_type = obj.class

        key = key.to_i if key_type == Array
        raise ArgumentError if key_type == Array && obj.size >= key
        raise ArgumentError if key_type == Hash && !obj.keys.include?(key)

        if path.empty?
          obj.delete_at(key) if key_type == Array
          obj.delete!(path.first) if key_type == Hash
        else
          obj[key] = recursive_remove(obj[key], path)
        end

        obj
      end
    end
  end
end

