require 'how_does/method_invoker'

module HowDoes
  module MadHax
    module_function
    @@blacklist = %w(daemonize display exec exit! fork sleep system syscall what?)
        
    def filter_methods methods
      methods.select { |m|
        m !~ /(should)|(assert)|(methods)/ && !@@blacklist.include?(m)
      }
    end
  
    def find_how original, target
      meths = original.methods
      filter_methods(meths).map { |m| 
        [m, get_result(original, m)]
      }.select { |m, r|
        r == target
      }.map { |m, r| 
        m 
      }
    end
  
    def get_result(o,m)
      MethodInvoker.invoke(o.dup, m)
    rescue
      :InvocationFail
    end
  end
end