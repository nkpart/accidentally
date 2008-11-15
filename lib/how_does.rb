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
      @blk = nil
    end
    
    def become result
      MadHax.find_how @object, result, @args, &@blk
    end
    
    def with *args, &blk
      @args.concat args
      @blk = blk
      self
    end
  end
end
