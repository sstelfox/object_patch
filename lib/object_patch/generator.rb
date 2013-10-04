
module ObjectPatch

  # This module handles the generation of patches between two objects.
  module Generator

    # Generate a series of patch operations that describe the changes from the
    # source object to the target object.
    #
    # @todo This doesn't do anything yet...
    # @param [Object] source The source document
    # @param [Object] target The target document we'll generate the
    #   differences for.
    # @return [Array<Hash>]
    def generate(source, target, current_path = [])
      if source.class != target.class
        # The simplest of cases is that we have incompatible types, in which
        # case we'll full replace the root. This of course could be optimized
        # for situations where the root as moved to a child element but that is
        # harder to detect...
        return [Operations::Replace.new("path" => Pointer.encode(current_path), "value" => target)]
      end

      case source.class
      when Hash
        return hash_compare(source, target, current_path)
      when Array
        return array_compare(source, target, current_path)
      else
        # A scaler value
        return [] if source == target
        return [Operations::Replace.new("path" => Pointer.encode(current_path), "value" => target)]
      end
    end

    def hash_compare(src_hash, tgt_hash, current_path)
      operations = []

      # Keys to remove
      (src_hash.keys - tgt_hash.keys).each do |k|
        operations.push(
          Operations::Test.new("path" => Pointer.encode(current_path + Array(k)), "value" => tgt_hash[k]),
          Operations::Remove.new("path" => Pointer.encode(current_path + Array(k)))
        )
      end

      # Missing keys to add
      (tgt_hash.keys - src_hash.keys).each do |k|
        operations.push(
          Operations::Add.new("path" => Pointer.encode(current_path + Array(k)))
        )
      end

      # When both hashes share the same key we need to go deeper...
      (src_hash.keys & tgt_hash.keys).each do |k|
        operations += generate(src_hash[k], tgt_hash[k], current_path + Array(k))
      end

      operations
    end

    def array_compare(src_hash, tgt_hash, current_path)
      operations = []
    end

    module_function :array_compare, :generate, :hash_compare
  end
end
