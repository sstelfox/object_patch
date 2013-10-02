
module ObjectPatch
  module Pointer
    def eval(path, obj)
      path.inject(obj) do |o, p|
        if o.is_a?(Hash)
          raise MissingKeyError unless o.keys.include?(p)
          o[p]
        else
          # The last element +1 is technically how this is interpretted. This
          # will always trigger the index error so it may not be valuable to
          # set...
          p = o.size if p == "-1"
          # Technically a violation of the RFC to allow reverse access to the
          # array but I'll allow it...
          raise ObjectPatch::ObjectOperationOnArrayError unless p.to_s.match(/\A-?\d+\Z/)
          raise ObjectPatch::IndexError unless p.to_i.abs < o.size
          o[p.to_i]
        end
      end
    end

    def encode(ary_path)
      ary_path = Array(ary_path).map { |p| p.is_a?(String) ? escape(p) : p }
      "/" << ary_path.join("/")
    end

    def escape(str)
      conv = { '~' => '~0', '/' => '~1' }
      str.gsub(/~|\//) { |m| conv[m] }
    end

    def parse(path)
      # Strip off the leading slash
      path = path.sub(/^\//, '')
      path.split("/").map { |p| p.match(/\A\d+\Z/) ? p.to_i : unescape(p) }
    end

    def unescape(str)
      conv = { '~0' => '~', '~1' => '/' }
      str.gsub(/~[01]/) { |m| conv[m] }
    end

    module_function :eval, :encode, :escape, :parse, :unescape
  end
end

