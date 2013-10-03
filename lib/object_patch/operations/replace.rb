
module ObjectPatch::Operations
  class Replace
    def initialize(patch_data)
      @path  = patch_data.fetch('path')
      @value = patch_data.fetch('value')
    end

    def apply(target_doc)
      return @value if processed_path.empty?

      key = processed_path.last
      inner_obj = ObjectPatch::Pointer.eval(processed_path[0...-1], target_doc)

      if inner_obj.is_a?(Array)
        raise ObjectPatch::InvalidIndexError unless key =~ /\A\d+\Z/
        inner_obj[key.to_i] = @value
      else
        inner_obj[key] = @value
      end

      target_doc
    end

    def processed_path
      ObjectPatch::Pointer.parse(@path)
    end

    def to_patch
      { 'op' => 'replace', 'path' => @path, 'value' => @value }
    end
  end
end

