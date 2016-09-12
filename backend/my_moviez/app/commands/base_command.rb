module BaseCommand
  attr_reader :result

  module ClassMethods
    def call(*args)
      new(*args).call
    end
  end

  def self.prepended(base)
    base.extend ClassMethods
  end

  def call
    raise NotImplementedError unless defined?(super)
    @called = true
    @result = super

    self
  end

  def success?
    called? && !failure?
  end

  def failure?
    called? && errors.any?
  end

  def errors
    @errors ||= Error.new
  end

  def errors=(other)
    @errors = other
  end

  private

  def called?
    @called ||= false
  end

  class Error < Hash
    def from_hash(h = {})
      h.each { |k, v| add(k, v) }
    end
    def add(key, value, opts = {})
      self[key] ||= []
      self[key] << value
      self[key].uniq!
    end

    def each
      each_key do |field|
        self[field].each { |msg| yield field, msg }
      end
    end

  end
end
