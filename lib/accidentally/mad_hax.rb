require 'accidentally/method_invoker'

module Accidentally
  module MadHax

    @@blacklist = %w(daemonize display exec exit! fork sleep system syscall what? what ri accidentally accidently)

    module_function
            
    def select_candidates methods
      methods.select { |m| m !~ /(should)|(assert)|(methods)/ && !@@blacklist.include?(m)}
    end
  
    def find_how original, target, args = [], &blk
      let(
        :f => proc { |m| MethodInvoker.invoke(original, m, args, &blk) },
        :candidates => proc { select_candidates(original.methods) }
      ).in {
        candidates.select { |m| f(m) == target }
      } 
    end
  
  end
end
