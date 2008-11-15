require 'how_does/patches/kernel'

module HowDoes
  class MethodInvoker
    def self.invoke v, meth
      self.new(v).invoke(meth)
    end
      
    def initialize v
      @v = v
    end
    
    def invoke meth
      v, warns = yield_and_collect_warns {
        invocation_result, fail = either { do_send(meth) }
        if (fail && fail.is_a?(LocalJumpError)) || is_a_187_block_result(invocation_result) then
          invoke_block_method(meth)
        else
          invocation_result
        end
      }
      #TODO handle the warns
      p warns if !warns.empty?
      v
    end
    
    def is_a_187_block_result x
      defined?(Enumerable::Enumerator) && x.is_a?(Enumerable::Enumerator)
    end
    
    def do_send meth, &blk
      # Executing with timeout in case of endless methods, like Array#cycle in 1.8.7
      execute_with_timeout {
        @v.dup.send(meth, &blk)
      }
    end
    
    def execute_with_timeout(timeout = 0.5)
      r = nil
      t = Thread.new {
        r = yield 
      }
      t.join(timeout)
      r
    end
    
    def invoke_block_method m
      blk = proc { |x| x }
      do_send(m, &blk)
    end
    
  end
end
