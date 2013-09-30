
module ObjectPatch
  module Pointer
    def decode(path)
      # Strip off the leading slash
      path = path[1..-1]
      path.split("/").map { |p| p.match(/\A\d+\Z/) ? p.to_i : unescape(p) }
    end

    def encode(ary_path)
      ary_path = Array(ary_path).map { |p| p.is_a?(String) ? escape(p) : p }

      "/" << ary_path.join("/")
    end

    def escape(str)
      str.gsub("~", "~0").gsub("/", "~1")
    end

    def unescape(str)
      str.gsub("~1", "/").gsub("~0", "~")
    end

    module_function :decode, :encode, :escape, :unescape
  end
end

