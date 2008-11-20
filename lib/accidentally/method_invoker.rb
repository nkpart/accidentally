require 'accidentally/patches/kernel'
require 'accidentally/patches/thread'
require 'accidentally/invocation_result'
  
module Accidentally  
  class MethodInvoker
      
    def self.invoke orig, meth, args, &blk
      # TODO This look bad. Too many places where invocation results are getting built
      # and failure happening.
      v, warns = yield_and_collect_stderr {
        value, fail = either { do_send(orig, meth, args, &blk) }
        if should_do_block_execute(value, fail) then
          r, fail = either { invoke_and_infer_block(orig, meth, args) }
          r || InvocationResult.new(fail)
        else
          InvocationResult.new(value)
        end
      }
      # TODO handle the warns     
      v       
    end
    
    private
    
    def self.should_do_block_execute(invocation_result, fail)
      let(
        :is_a_187_block_result => proc { |x| defined?(Enumerable::Enumerator) && x.is_a?(Enumerable::Enumerator) },
        :failed_because_no_block => proc { |fail| (fail && fail.is_a?(LocalJumpError)) }
      ).in {
        failed_because_no_block(fail) || is_a_187_block_result(invocation_result)
      }
    end

    def self.do_send orig, meth, args, &blk
      # Executing with timeout in case of endless methods, like Array#cycle in 1.8.7
      Thread.execute_with_timeout { dup(orig).send(meth, *args, &blk) } 
    end
    
    def self.dup value
      value.dup
    rescue TypeError
      value
    end
    
    def self.invoke_and_infer_block orig, m, args
      proc_body = "{ |x| x }"
      blk = eval "proc #{proc_body}"
      v = do_send(orig, m, args, &blk)
      InvocationResult.new(v, proc_body)
    end
  end
end
