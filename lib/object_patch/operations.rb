
require "object_patch/operations/add"
require "object_patch/operations/copy"
require "object_patch/operations/move"
require "object_patch/operations/remove"
require "object_patch/operations/replace"
require "object_patch/operations/test"

# These operations take advantage of the fact that Pointer#eval returns the same
# object (obj.object_id match) and thus any changes made to the extracted object
# will be reflected in the original deeply nested object.
module ObjectPatch
  module Operations

    # Add a value at the provided key within the provided object. This will behave
    # differently depending on whether we're processing a hash or an array as the
    # target destination.
    #
    # It is important to note that this behaves by adjusting the state of the
    # provided object. It does not return the new object itself!
    #
    # @param [Array, Hash] target_obj The object that will have the value added.
    # @param [Fixnum,String] key The index / key where the new value will be
    #   inserted.
    # @param [Object] new_value The value to insert at the specified location.
    # @return [void]
    def add_op(target_obj, key, new_value)
      if target_obj.is_a?(Array)
        target_obj.insert(check_array_index(key, target_obj.size), new_value)
      else
        target_obj[key] = new_value
      end
    end

    # Validates that the array index provided falls within the acceptable range or
    # in the event we have received the special '-' index defined in the JSON
    # Pointer RFC we treat it as the last element.
    #
    # @param [String,Fixnum] index The index value to validate
    # @param [Fixnum] array_size The size of the array this index will be used
    #   within (Used for bounds checking).
    # @return [Fixnum] Valid index
    def check_array_index(index, array_size)
      return -1 if index == "-"
      raise ObjectOperationOnArrayException unless index =~ /\A-?\d+\Z/

      index = index.to_i

      # There is a bug in the IETF tests that require us to allow patches to set a
      # value at the end of the array. The final '<=' should actually be a '<'.
      raise OutOfBoundsException unless (0 <= index && index <= array_size)

      index
    end

    # Remove a hash key or index from the provided object.
    #
    # It is important to note that this behaves by adjusting the state of the
    # provided object. It does not return the new object itself!
    #
    # @param [Array, Hash] target_obj The object that will have the value removed.
    def rm_op(target_obj, key)
      if target_obj.is_a?(Array)
        raise InvalidIndexError unless key =~ /\A\d+\Z/
        target_obj.delete_at(check_array_index(key, target_obj.size))
      else
        raise(MissingTargetException, key) unless target_obj.has_key?(key)
        target_obj.delete(key)
      end
    end

    module_function :add_op, :check_array_index, :rm_op
  end
end

