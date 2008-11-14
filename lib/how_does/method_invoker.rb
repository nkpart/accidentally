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
        v = @v.send(meth)
      }
      p warns if !warns.empty?
      v
    rescue LocalJumpError => e
      blk = proc { |x| x }
      @v.send(meth, &blk)
    end
    
    def collect_warns
      old_err = $stderr
      new_err = StringIO.new
      class <<new_err
        def write v
          super v
        end
      end
      $stderr = new_err
      yield
      $stderr = old_err
      new_err.string
    end
  end
end
