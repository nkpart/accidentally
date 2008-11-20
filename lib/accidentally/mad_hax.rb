require 'accidentally/method_invoker'

module Accidentally
  @@blacklist = %w(daemonize display exec exit! fork sleep system syscall what? what ri accidentally accidently)

    module_function
  
    def find_how original, target, args = [], &blk
      select_candidates(original).inject([]) { |acc, m| 
        v = MethodInvoker.invoke(original, m, args, &blk)
        acc << "#{m}#{" " + v.block_used if v.block_used}" if v.result == target 
        acc
      }        
    end

    def select_candidates original
      original.methods.select { |m| m !~ /(should)|(assert)|(methods)/ && !@@blacklist.include?(m)}
    end  
end
