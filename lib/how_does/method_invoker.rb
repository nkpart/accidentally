module HowDoes
  class MethodInvoker
    def self.invoke v, meth
      self.new(v).invoke(meth)
    end
      
    def initialize v
      @v = v
    end
    
    def invoke meth
      v = nil
      warns = collect_warns {
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
    
    def collect_warns
      old_err = $stderr
      new_err = StringIO.new
      $stderr = new_err
      yield
      $stderr = old_err
      new_err.string
    end
  end
end
