$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'how_does/mad_hax'

module HowDoes
  VERSION = '0.0.1'

  module_function
  
  def how_does object
    Proxy.new object
  end

  def howdy_doodie hash
    key = hash.keys.first
    Proxy.new(key).become(hash[key])
  end
  
  class Proxy
    def initialize object
      @object = object
      @args = []
    end
    
    def become result
      MadHax.find_how @object, result, @args
    end
    
    def with *args
      @args.concat args
      self
    end
  end
end
