$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'how_does/method_analyser'

module HowDoes
  VERSION = '0.0.1'
  
  class Proxy
    def initialize v
      @v = v
    end
    
    def become result
      meths = MethodAnalyser.new(@v).methods_by_arity[0]
      meths.map { |m| 
        [m, get_result(m)]
      }.select { |m, r| r == result }.map { |m, r| m }
    end
    
    def get_result(m)
      @v.dup.send(m)
    rescue
      nil 
    end
  end
  
  module_function
  def how_does v
    Proxy.new(v)
  end
  
end