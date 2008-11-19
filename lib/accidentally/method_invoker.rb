require 'accidentally/patches/kernel'
require 'accidentally/patches/thread'

class InvocationResult < Strucked.build(:result, :block_used); end
  
module Accidentally  
  class MethodInvoker
    def self.invoke v, meth, args, &blk
      self.new(v).invoke(meth, args, &blk)
    end
      
    def initialize v
      @v = v
    end
    
    def invoke meth, args, &blk
      v, warns = yield_and_collect_stderr {
        invocation_result, fail = either { do_send(meth, args, &blk) }
        if should_do_block_execute(invocation_result, fail) then
          either { invoke_and_infer_block(meth, args) }.compact.first
        else
          invocation_result
        end
      }
      # TODO handle the warns            
      v
    end
    
    private
    
    def should_do_block_execute(invocation_result, fail)
      let(
        :is_a_187_block_result => proc { |x| defined?(Enumerable::Enumerator) && x.is_a?(Enumerable::Enumerator) },
        :failed_because_no_block => proc { |fail| (fail && fail.is_a?(LocalJumpError)) }
      ).in {
        failed_because_no_block(fail) || is_a_187_block_result(invocation_result)
      }
    end

    def do_send meth, args, &blk
      # Executing with timeout in case of endless methods, like Array#cycle in 1.8.7
      Thread.execute_with_timeout { dup(@v).send(meth, *args, &blk) } 
    end
    
    def dup value
      (value.is_a? Fixnum) ? value : value.dup
    end
    
    def invoke_and_infer_block m, args
      blk = proc { |x| x }
      do_send(m, args, &blk)
    end
  end
end
