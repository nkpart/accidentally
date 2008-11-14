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
        begin
          v = @v.send(meth)          
        rescue LocalJumpError => e
          blk = proc { |x| x }
          v= @v.send(meth, &blk)   
        end
      }
      p warns if !warns.empty?
      v
    end
    
    def yield_and_collect_warns
      old_err = $stderr
      $stderr = StringIO.new
      r = yield
      warns = $stderr.string
      $stderr = old_err
      [r, warns]
    end
  end
end
