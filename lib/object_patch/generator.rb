
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

      case source.class.to_s
      when "Hash"
        return hash_compare(source, target, current_path)
      when "Array"
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
        path = Pointer.encode(current_path + Array(k))
        operations.push(
          Operations::Test.new("path" => path, "value" => src_hash[k]),
          Operations::Remove.new("path" => path)
        )
      end

      # Missing keys to add
      (tgt_hash.keys - src_hash.keys).each do |k|
        path = Pointer.encode(current_path + Array(k))
        operations.push(
          Operations::Add.new("path" => path, "value" => tgt_hash[k])
        )
      end

      # When both hashes share the same key we need to go deeper...
      (src_hash.keys & tgt_hash.keys).each do |k|
        operations += generate(src_hash[k], tgt_hash[k], current_path + Array(k))
      end

      operations
    end

    def array_compare(src_ary, tgt_ary, current_path)
      operations = []

      if src_ary.size > tgt_ary.size
        # We'll need to remove some elements
        base_size = tgt_ary.size
        src_ary[base_size..-1].each_with_index do |itm, idx|
          path = Pointer.encode(current_path + Array(base_size + idx))
          operations.push(
            Operations::Test.new("path" => path, "value" => src_ary[base_size + idx]),
            Operations::Remove.new("path" => path)
          )
        end
      elsif src_ary.size < tgt_ary.size
        # We'll need to add some elements
        base_size = tgt_ary.size
        src_ary[base_size..-1].each_with_index do |itm, idx|
          path = Pointer.encode(current_path + Array(base_size + idx))
          operations.push(
            Operations::Add.new("path" => path, "value" => tgt_ary[base_size + idx]),
          )
        end
      end

      # Compare the existing values in the array
      smallest_length = (src_ary.size > tgt_ary.size) ? tgt_ary.size : src_ary.size
      smallest_length.times do |n|
        # Handle arrays and hashes in a special way as their values are
        # potentially not going to be able to hold up to a comparison.
        if src_ary[n].is_a?(Array) || src_ary[n].is_a?(Hash) || tgt_ary[n].is_a?(Array) || tgt_ary[n].is_a?(Hash)
          operations.push(*generate(src_ary[n], tgt_ary[n], current_path + Array(n)))
          next
        end

        # We've gotten the complicated cases out, this is a simple test and
        # replace.
        unless src_ary[n] == tgt_ary[n]
          path = Pointer.encode(current_path + Array(n))
          operations.push(
            Operations::Test.new("path" => path, "value" => src_ary[n]),
            Operations::Replace.new("path" => path, "value" => tgt_ary[n]),
          )
        end
      end

      operations
    end

    module_function :array_compare, :generate, :hash_compare
  end
end
