
module ObjectPatch
  module Pointer
    def eval(path, obj)
      path.inject(object) do |o, p|
        if o.is_a?(Array)
          raise ObjectPatch::IndexError unless p.match(/\A-?\d+\Z/)
          raise ObjectPatch::IndexError unless p.to_i.abs < p.size
          o[p.to_i]
        else
          raise MissingKeyError unless o.keys.include?(p)
          o[p]
        end
      end
    end

    def parse(path)
      # Strip off the leading slash
      path = path.sub(/^\//, '')
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

