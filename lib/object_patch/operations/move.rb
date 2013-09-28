
module ObjectPatch
  module Operations
    class Move
      def initialize(patch_hash)
        @patch = patch_hash
      end

      def apply(source_hash)
        source_hash
      end
    end
  end
end

