
module ObjectPatch
  module Operations
    class Move
      def initialize(patch_hash)
        @from = ObjectPatch::Pointer.parse(patch_hash.fetch("from"))
        @to = ObjectPatch::Pointer.parse(patch_hash.fetch("path"))
      end

      def apply(source_hash)
        current = ObjectPatch::Pointer.eval(@from, source_hash)
        source_hash = Remove.new({'path' => @from}).apply(source_hash)
        Add.new({'path' => @to, 'value' => current}).apply(source_hash)
      end
    end
  end
end

