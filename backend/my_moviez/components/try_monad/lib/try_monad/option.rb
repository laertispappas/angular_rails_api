module TryMonad
  class Option
    # Include Enumerable

    def to_a
    end

    def ==(other)
      other.class == self.class
    end
    alias_method :eql?, :==

    def inspect
      to_s
    end
  end
end
