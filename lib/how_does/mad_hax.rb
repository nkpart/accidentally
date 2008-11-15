require 'how_does/method_invoker'
require 'how_does/invocation_fail_exception'
module HowDoes
  module MadHax

    @@blacklist = %w(daemonize display exec exit! fork sleep system syscall what?)

    module_function
            
    def select_candidates methods
      methods.select { |m|
        m !~ /(should)|(assert)|(methods)/ && !@@blacklist.include?(m)
      }
    end
  
    def find_how original, target, args = []
      select_candidates(original.methods).map { |m| 
        [m, get_result(original, m, args)]
      }.select { |m, r|
        r == target
      }.map { |m, r| 
        m 
      }
    end
  
    def get_result(o,m, args)
      MethodInvoker.invoke(o, m, args)
    rescue Exception => e
      InvocationFailException.new(e)
    end
  end
end