
module ObjectPatch
  module Operations
    class Move
      def initialize(patch_hash)
        @from = patch_hash.fetch("from")
        @to = patch_hash.fetch("path")
      end

      def apply(source_hash)
        current = ObjectPatch::Pointer.eval(ObjectPatch::Pointer.parse(@from), source_hash)
        source_hash = Remove.new({'path' => @from}).apply(source_hash)
        Add.new({'path' => @to, 'value' => current}).apply(source_hash)
      end
    end
  end
end

