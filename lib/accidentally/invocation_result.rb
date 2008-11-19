module Accidentally
  class InvocationResult
    def initialize result, block_used = nil
      @result= result
      @block_used = block_used
    end
  
    attr_reader :result, :block_used
    
    def == other
      self.result == other.result && self.block_used == other.block_used
    end
  end
end
