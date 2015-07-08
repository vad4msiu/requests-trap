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
      Oj.dump(value)
    end
  end
end