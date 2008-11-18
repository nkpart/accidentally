$: << File.expand_path(File.dirname(__FILE__))

require 'rubygems'
gem 'nkpart-prohax'
require 'prohax'
require 'accidently/mad_hax'

class Object
  def accidently *args, &block
    Accidently::Proxy.new(self).with(*args, &block)
  end
end

module Accidently
  VERSION = '0.0.1'

  class Proxy
    def initialize object
      @object = object
      @args = []
      @block = nil
    end

    def == result
      MadHax.find_how @object, result, @args, &@block
    end

    def with *args, &block
      @args.concat args
      @block = block
      self
    end
  end
end
