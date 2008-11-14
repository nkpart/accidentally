$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'how_does/mad_hax'
module HowDoes
  VERSION = '0.0.1'

  module_function
  def how_does v
    Proxy.new(v)
  end
  
  class Proxy
    def initialize v
      @v = v
    end
    
    def become result
      z= MadHax.find_how @v, result
      z
    end
  end
end
