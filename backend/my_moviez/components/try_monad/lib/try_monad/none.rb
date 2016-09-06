require 'try_monad/option'
module TryMonad
  class None < Option
    class ExpectedValueException < Exception; end

    def initialize(value)
      @value = value
    end

    def get
      raise ExpectedValueException.new("get called to None. A value is expected!")
    end

    def or_else(els = nil)
      block_given? ? yield : els
    end

    def or_raise(*args)
    end

    def or_nil
      nil
    end

    def some?
      false
    end

    def none?
      true
    end

    def method_missing(sym_name, *args, &block)
    end

    def to_s
      "None"
    end

    private
  end
end
