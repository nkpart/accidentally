module HowDoes
  class MethodAnalyser
    def initialize v
      @v = v
    end
    
    def methods_by_arity
      h = {}
      @v.methods.each do |m|
        arity = @v.method(m).arity
        (h[arity] ||= []) << m
      end
      h
    end
  end
end
