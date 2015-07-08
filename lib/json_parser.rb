class JsonParser
  class << self
    def load(value)
      case value
      when Hash, HashWithIndifferentAccess, Array
        value
      when String
        Oj.load(value)
      when NilClass
        nil
      else
        raise "Undefined type for '#{ value }'"
      end
    end

    def dump(value)
      case value
      when Hash, HashWithIndifferentAccess
        Oj.dump(value.stringify_keys)
      else
        Oj.dump(value)
      end
    end
  end
end