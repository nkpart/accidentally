require 'how_does/patches/kernel'
require 'how_does/patches/thread'
require 'how_does/patches/object'

module HowDoes
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
          either { invoke_block_method(meth, args) }.compact.first
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
        :is_a_187_block_result => proc { |x| 
          defined?(Enumerable::Enumerator) && x.is_a?(Enumerable::Enumerator) 
        }
      ).in {
        (fail && fail.is_a?(LocalJumpError)) || is_a_187_block_result(invocation_result)
      }
    end

    def do_send meth, args, &blk
      # Executing with timeout in case of endless methods, like Array#cycle in 1.8.7
      Thread.execute_with_timeout { @v.dup.send(meth, *args, &blk) } 
    end
    
    def invoke_block_method m, args
      do_send(m, args) { |x| x }
    end
  end
end
