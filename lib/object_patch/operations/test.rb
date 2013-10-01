
module ObjectPatch
  module Operations
    class Test
      def initialize(patch_hash)
        @path = ObjectPatch::Pointer.parse(patch_hash.fetch("path"))
        @value = patch_hash.fetch("value")
      end

      def apply(source_hash)
        raise TestOperationFailed unless (ObjectPatch::Pointer.eval(@path, source_hash) == @value)
      end
    end
  end
end

