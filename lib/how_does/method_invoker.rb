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
          x = do_send(meth)
          if defined?(Enumerable::Enumerator) && x.is_a?(Enumerable::Enumerator) then
            invoke_block_method(meth)
          else 
            x
          end   
        rescue LocalJumpError => e
          invoke_block_method(meth)
        end
      }
      p warns if !warns.empty?
      v
    end
    
    def do_send meth, &blk
      # Executing with timeout in case of endless methods, like Array#cycle in 1.8.7
      r = nil
      t = Thread.new {
        r = @v.dup.send(meth, &blk)
      }
      t.join(0.5)
      r
    end
    
    def invoke_block_method m
      blk = proc { |x| x }
      v= do_send(m, &blk)
    end
    
    def yield_and_collect_warns
      # so many lol effects
      old_err = $stderr
      $stderr = StringIO.new
      r = yield
      warns = $stderr.string
      $stderr = old_err
      [r, warns]
    end
    
  end
end
