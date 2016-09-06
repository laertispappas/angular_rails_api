require 'try_monad/option'

module TryMonad
  class Some < Option
    def initialize(value)
      @value = value
    end

    def get
      @value
    end

    def or_else(*)
      @value
    end

    def or_raise(*)
      @value
    end

    def or_nil
      @value
    end

    def some?
      true
    end

    def none?
      false
    end

    def ==(other)
      super && get == other.get
    end

    def ===(other)
      other && other.class == self.class && @value === other.get
    end

    def method_missing(name, *args, &block)
    end

    def to_s
      "Some(#{@value})"
    end

    private
  end
end
