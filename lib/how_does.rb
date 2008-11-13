$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'how_does/method_invoker'

module HowDoes
  VERSION = '0.0.1'
  
  class Proxy
    def initialize v
      @v = v
    end
    
    def become result
      meths = @v.methods
      meths.select { |m|
        m !~ /(should)|(assert)|(methods)/
      }.map { |m| 
        [m, get_result(m)]
      }.select { |m, r|
        p [m, r] 
        r == result 
      }.map { |m, r| m }
    end
    
    def get_result(m)
      MethodInvoker.invoke(@v.dup, m)
    rescue
      :FAILT
    end
  end
  
  module_function
  def how_does v
    Proxy.new(v)
  end
  
end