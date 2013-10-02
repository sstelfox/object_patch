
module ObjectPatch
  module Operations
    class Test
      def initialize(patch_hash)
        @path = ObjectPatch::Pointer.parse(patch_hash.fetch("path"))
        @value = patch_hash.fetch("value")
      end

      def apply(source_hash)
        unless (ObjectPatch::Pointer.eval(@path, source_hash) == @value)
          raise TestOperationFailed.new(@path, @value) 
        end
      end
    end
  end
end

