
module ObjectPatch
  module Pointer
    def encode(ary_path)
      ary_path.map! { |i| i.gsub("~", "~0") }
      ary_path.map! { |i| i.gsub("/", "~1") }
      ary_path.join("/")
    end

    def decode(path)
      path.split("/").map do |p|
        p.gsub!("~1", "/")
        p.gsub!("~0", "~")
      end
    end

    module_function :decode, :encode
  end
end

