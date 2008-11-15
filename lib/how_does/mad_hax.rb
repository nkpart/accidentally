require 'how_does/method_invoker'
require 'how_does/invocation_fail_exception'
module HowDoes
  module MadHax

    @@blacklist = %w(daemonize display exec exit! fork sleep system syscall what? what ri)

    module_function
            
    def select_candidates methods
      methods.select { |m|
        m !~ /(should)|(assert)|(methods)/ && !@@blacklist.include?(m)
      }
    end
  
    def find_how original, target, args = [], &blk
      let(
        :f => proc { |m| get_result(original, m, args, &blk) },
        :candidates => proc { select_candidates(original.methods) }
      ).in {
        candidates.map { |m| [m, f(m)] }.select { |m, r| r == target }.map { |m, r| m}
      } 
    end
  
    def get_result(o,m, args, &blk)
      MethodInvoker.invoke(o, m, args, &blk)
    rescue Exception => e
      InvocationFailException.new(e)
    end
  end
end
