module Kernel
  
  # do error handling via the function Either[A, B] type, a little bit
  def either
    [yield, nil] 
  rescue Exception => e
    [nil, e]
  end
  
  
  def yield_and_collect_stderr
    # so many lol effects
    old_err = $stderr
    $stderr = StringIO.new
    r = yield
    warns = $stderr.string
    [r, warns]
  ensure
    $stderr = old_err
  end
  
  class LetProxy
    class Container
      # TODO undefine a lot of shiz
      def initialize defines
        @defines = defines
      end
      
      def method_missing sym,*args, &blk
        @defines[sym]
      end
    end
    
    def initialize defines
      @defines = defines
    end
    
    def in &blk
      Container.new(@defines).instance_eval &blk
    end
  end
  
  def let defines
    LetProxy.new(defines)
  end
end
