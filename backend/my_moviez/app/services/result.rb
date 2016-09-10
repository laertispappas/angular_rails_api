module Result
  module Common
    attr_reader :data, :success
    def success?
      @success ||= false
    end
    def failure?
      @success
    end
  end
  class Success
    include Common
    def initialize(data = nil)
      @data = data
      @success = true
    end

    def on_success(&block)
      block.call(data)
      self
    end

    def on_failure(&block)
      self
    end

    def and_then(&block)
      raise NotImplementedError
    end
  end

  class Failure
    include Common
    def initialize(error, data = nil)
      if error.is_a? StandardError
        @error_msg = error.message
        @data = error
      else
        @error_msg = error
        @data = data
      end
    end


    def on_success(&block)
      self
    end

    def on_failure(&block)
      block.call(error_msg, data)
      self
    end

    def and_then(&block)
      self
    end
  end
end
