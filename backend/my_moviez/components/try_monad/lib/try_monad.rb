require "try_monad/version"
require 'try_monad/none'
require 'try_monad/some'

module TryMonad
end

# 
# Try(obj.foo).or_else { "Other value" }
def Try(value)
  if value.nil? || (value.respond_to?(:size) && value.size == 0)
    None(nil)
  else
    Some(value)
  end
end

def Some(value)
  Some.new(value)
end

def None(value)
  None.new(value)
end
