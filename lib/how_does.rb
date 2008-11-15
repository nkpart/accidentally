$: << File.expand_path(File.dirname(__FILE__))

require 'how_does/mad_hax'

module HowDoes
  VERSION = '0.0.1'

  module_function

  def how_does object
    Proxy.new object
  end

  class Proxy
    def initialize object
      @object = object
      @args = []
      @block = nil
    end

    def become result
      MadHax.find_how @object, result, @args, &@block
    end

    alias :returns :become
    
    def with *args, &block
      @args.concat args
      @block = block
      self
    end
  end
end
