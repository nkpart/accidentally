module HowDoes
  class MethodInvoker
    def self.invoke v, meth
      self.new(v).invoke(meth)
    end
      
    def initialize v
      @v = v
    end
    
    def invoke meth
      @v.send(meth)
    rescue LocalJumpError => e
      blk = proc { |x| x }
      @v.send(meth, &blk)
    end
  end
end
